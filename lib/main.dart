import 'app/app.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/models/password_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Registra o adapter
  Hive.registerAdapter(PasswordModelAdapter());

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

  // Abre o box criptografado
  await Hive.openBox<PasswordModel>(
    'senhas',
    encryptionCipher: HiveAesCipher(keyBytes),
  );

  runApp(const PasswordManager());
}
