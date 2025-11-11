import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_password_manager/ui/widgets/image_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../../app/models/image_model.dart';
import '../../app/services/password_service.dart';
import '../../app/models/password_model.dart';
import '../widgets/password_card.dart';

class PasswordsScreen extends StatefulWidget {
  const PasswordsScreen({super.key});

  @override
  State<PasswordsScreen> createState() => _PasswordsScreenState();
}

class _PasswordsScreenState extends State<PasswordsScreen> {
  final TextEditingController _siteController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final PasswordService _passwordService = PasswordService();
  late ScaffoldMessengerState messenger;
  late Box<PasswordModel> box;
  XFile? _imgCtrl;

  @override
  void initState() {
    super.initState();
    box = _passwordService.getBox;
  }

  Future<void> _editPassword(int index) async {
    if (await _passwordService.editPassword(
      index: index,
      site: _siteController.text,
      usuario: _usuarioController.text,
      senha: _senhaController.text,
      image: _imgCtrl
    )) {
      messenger.showSnackBar(
        SnackBar(content: Text('Atualizado com seucesso!')),
      );
    } else {
      messenger.showSnackBar(
        SnackBar(content: Text('Não foi possivel atualizar.')),
      );
    }
    setState(() {}); // força rebuild para atualizar a UI
  }

  Future<void> _deletePassword(int index) async {
    if (await _passwordService.deletePassword(index)) {
      messenger.showSnackBar(
        SnackBar(content: Text('A senha foi apagada com sucesso!')),
      );
    } else {
      messenger.showSnackBar(
        SnackBar(content: Text('Não foi possivel apagar a senha.')),
      );
    }
    setState(() {}); // força rebuild para atualizar a UI
  }

  Widget _buildImagem(ImageModel? imagem) {
    if (imagem == null || imagem.caminho.isEmpty) {
      return const Icon(Icons.image_not_supported, size: 50);
    }

    final file = File(imagem.caminho);
    if (!file.existsSync()) {
      return const Icon(Icons.image_not_supported, size: 50);
    }

    return Image.file(
      file,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
    );
  }

  @override
  Widget build(BuildContext context) {
    messenger = ScaffoldMessenger.of(context);

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<PasswordModel> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('Nenhuma senha salva ainda.'));
          }
          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.45,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 13),
                itemCount: box.length,
                itemBuilder: (context, index) {
                  final passwordInfos = box.getAt(index)!;
                  return PasswordCard(
                    site: passwordInfos.site,
                    user: passwordInfos.usuario,
                    password: passwordInfos.senha,
                    image: _buildImagem(passwordInfos.imagem),
                    showEditDialog: () => _showEditDialog(index),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showEditDialog(int index) {
    final passwordInfos = box.getAt(index)!;
    _siteController.text = passwordInfos.site;
    _usuarioController.text = passwordInfos.usuario;
    _senhaController.text = passwordInfos.senha;
    _imgCtrl = passwordInfos.imagem != null
        ? _passwordService.getByPath(passwordInfos.imagem!.caminho)
        : null;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          'Editar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            EscolherImagemWidget(
              image: _imgCtrl,
              onChanged: (value) {
                setState(() {
                  _imgCtrl = value;
                });
              },
            ),
            TextField(
              controller: _siteController,
              decoration: const InputDecoration(labelText: 'Site'),
            ),
            TextField(
              controller: _usuarioController,
              decoration: const InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _senhaController,
              decoration: const InputDecoration(labelText: 'Senha'),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              _deletePassword(index);
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              _editPassword(index);
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
