import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:io';
import 'app/models/password_model.dart';
import 'app/models/image_model.dart';
import 'app/app.dart';

Future<void> main() async {
  // Define uma pasta para os arquivos do banco
  final appDir = await getApplicationDocumentsDirectory();
  final hiveDir = Directory('${appDir.path}/Password Manager/DB');

  if (!await hiveDir.exists()) {
    await hiveDir.create(recursive: true);
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(hiveDir.path);

  // Registra o adapter
  Hive.registerAdapter(PasswordModelAdapter());
  Hive.registerAdapter(ImageModelAdapter());

  // Gera ou recupera a chave de criptografia
  const secureStorage = FlutterSecureStorage();
  var containsKey = await secureStorage.containsKey(key: 'hive_key');

  if (!containsKey) {
    var key = Hive.generateSecureKey();
    await secureStorage.write(key: 'hive_key', value: key.join(','));
  }

  var storedKey = (await secureStorage.read(key: 'hive_key'))!;
  var keyBytes = Uint8List.fromList(
    storedKey.split(',').map(int.parse).toList(),
  );

  // final oldBox = await Hive.openBox<PasswordModel>('senhas');
  // await oldBox.deleteFromDisk(); // apaga o arquivo fisicamente

  // final oldBox2 = await Hive.openBox<ImageModel>('imagens');
  // await oldBox2.deleteFromDisk(); // apaga o arquivo fisicamente

  // Abre o box criptografado
  await Hive.openBox<PasswordModel>(
    'senhas',
    encryptionCipher: HiveAesCipher(keyBytes),
  );
  await Hive.openBox<ImageModel>('images');

  runApp(const PasswordManager());
}
