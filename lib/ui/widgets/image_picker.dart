import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:pasteboard/pasteboard.dart';

class EscolherImagemWidget extends StatefulWidget {
  final XFile? image;
  final ValueChanged<XFile?> onChanged;

  const EscolherImagemWidget({super.key, this.image, required this.onChanged});

  @override
  State<EscolherImagemWidget> createState() => _EscolherImagemWidgetState();
}

class _EscolherImagemWidgetState extends State<EscolherImagemWidget> {
  XFile? _image;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _image = widget.image;
  }

  @override
  void didUpdateWidget(covariant EscolherImagemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.image != widget.image) {
      setState(() => _image = widget.image);
    }
  }

  Future<void> _pegarImagem() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _image = picked);
      widget.onChanged(picked);
    }
  }

  Future<void> _colarImagem() async {
    final imageBytes = await Pasteboard.image;
    if (imageBytes != null) {
      final tempFile = File(
        '${Directory.systemTemp.path}/clipboard_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      await tempFile.writeAsBytes(imageBytes);
      final xfile = XFile(tempFile.path);
      setState(() => _image = xfile);
      widget.onChanged(xfile);
    }
  }

  void _limparImagem() {
    setState(() => _image = null);
    widget.onChanged(null);
  }

  Widget imgWidget() {
    if (_image == null ||
        _image!.path.isEmpty ||
        !File(_image!.path).existsSync()) {
      return const Icon(Icons.image_not_supported, size: 100);
    }
    return Image.file(
      File(_image!.path),
      width: 100,
      height: 100,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragEntered: (_) => setState(() => _isDragging = true),
      onDragExited: (_) => setState(() => _isDragging = false),
      onDragDone: (detail) async {
        if (detail.files.isEmpty) return;

        final file = detail.files.first;
        if (file.path.isNotEmpty) {
          // arquivo local
          final xfile = XFile(file.path);
          setState(() => _image = xfile);
          widget.onChanged(xfile);
        } else if (file.name.startsWith('http')) {
          // URL do navegador (opcional)
          // baixar imagem via HTTP se quiser
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: _isDragging ? Colors.blue : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imgWidget(),
            const SizedBox(width: 10),
            Column(
              children: [
                IconButton(
                  onPressed: _pegarImagem,
                  icon: const Icon(Icons.image_search),
                ),
                // const SizedBox(height: 5),
                IconButton(
                  onPressed: _colarImagem,
                  icon: const Icon(Icons.paste),
                ),
                IconButton(
                  onPressed: _limparImagem,
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
            const SizedBox(width: 3),
          ],
        ),
      ),
    );
  }
}
