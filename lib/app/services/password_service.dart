import 'dart:io';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../models/image_model.dart';
import '../models/password_model.dart';

class PasswordService {
  final box = Hive.box<PasswordModel>('senhas');

  get getBox => box;

  Future<List<PasswordModel>> getAll() async {
    List<PasswordModel> lista = [];

    if (box.isNotEmpty) {
      for (PasswordModel item in box.values) {
        lista.add(item);
      }
    }

    return lista;
  }

  XFile? getByPath(String path) {
    return XFile(path);
  }

  Future<bool> addPassword(
    String site,
    String user,
    String senha,
    XFile? image,
  ) async {
    if (site.isEmpty || senha.isEmpty) return false;

    final appDir = await getApplicationDocumentsDirectory();

    // Caminho da pasta onde as imagens ficarão
    final imagesDir = Directory('${appDir.path}/Password Manager/Images');

    // Cria a pasta se não existir
    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }

    // Caminho final da nova imagem
    final newPath =
        '${imagesDir.path}/${DateTime.now().millisecondsSinceEpoch}.png';

    // Copia a imagem pra dentro da pasta
    if (image != null) {
      await File(image.path).copy(newPath);
    }

    // Cria o modelo com o caminho novo
    final nova = PasswordModel(
      site: site,
      usuario: user,
      senha: senha,
      imagem: ImageModel(
        nome: '${box.length + 1}',
        caminho: image != null ? newPath : '',
      ),
    );

    // Adiciona no Hive
    await box.add(nova);

    return true;
  }

  Future<bool> editPassword({
    required int index,
    required String site,
    required String usuario,
    required String senha,
    required XFile? image,
  }) async {
    final passwordToEdit = box.getAt(index)!;

    if (passwordToEdit.isInBox) {
      try {
        passwordToEdit.site = site;
        passwordToEdit.usuario = usuario;
        passwordToEdit.senha = senha;
        if (image == null) {
          passwordToEdit.imagem == null;
          if (passwordToEdit.imagem != null &&
              passwordToEdit.imagem!.caminho.isNotEmpty) {
            final file = File(passwordToEdit.imagem!.caminho);
            if (await file.exists()) {
              await file.delete();
            }
          }
        } else {
          if (passwordToEdit.imagem!.caminho != image.path) {
            if (passwordToEdit.imagem != null &&
                passwordToEdit.imagem!.caminho.isNotEmpty) {
              final file = File(passwordToEdit.imagem!.caminho);
              if (await file.exists()) {
                await file.delete();
              }
            }
            final appDir = await getApplicationDocumentsDirectory();

            // Caminho da pasta onde as imagens ficarão
            final imagesDir = Directory(
              '${appDir.path}/Password Manager/Images',
            );

            // Cria a pasta se não existir
            if (!await imagesDir.exists()) {
              await imagesDir.create(recursive: true);
            }

            final String imageName =
                '${DateTime.now().millisecondsSinceEpoch}.png';
            // Caminho final da nova imagem
            final newPath = '${imagesDir.path}/$imageName';

            // Copia a imagem pra dentro da pasta
            await File(image.path).copy(newPath);

            passwordToEdit.imagem = ImageModel(
              nome: imageName,
              caminho: newPath,
            );
          }
        }

        await box.putAt(index, passwordToEdit);
      } on Exception {
        return false;
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deletePassword(int index) async {
    final senha = box.getAt(index);

    try {
      if (senha?.imagem != null && senha!.imagem!.caminho.isNotEmpty) {
        final file = File(senha.imagem!.caminho);
        if (await file.exists()) {
          await file.delete();
        }
      }

      await box.deleteAt(index);
    } on Exception {
      return false;
    }
    return true;
  }
}
