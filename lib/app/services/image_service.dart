import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import '../models/image_model.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();
  final Box<ImageModel> box = Hive.box<ImageModel>('images');

  Future<XFile?> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      return pickedFile;
    }
    return null;
  }

  Future<bool> addImagem() async {
    final XFile? file = await pickImage();
    if (file == null) return false;

    // salva cópia no diretório do app
    final appDir = await getApplicationDocumentsDirectory();
    final newPath =
        '${appDir.path}/${DateTime.now().millisecondsSinceEpoch}.png';
    await File(file.path).copy(newPath);

    // salva o caminho no Hive
    final imagem = ImageModel(nome: 'foto_${box.length + 1}', caminho: newPath);
    await box.add(imagem);

    return true;
  }

  List<ImageModel> getAll() => box.values.toList();
}
