import 'package:hive/hive.dart';
import 'image_model.dart';

part 'password_model.g.dart';

@HiveType(typeId: 0)
class PasswordModel extends HiveObject {
  @HiveField(0)
  String site;

  @HiveField(1)
  String usuario;

  @HiveField(2)
  String senha;

  @HiveField(3)
  ImageModel? imagem; // campo opcional

  PasswordModel({
    required this.site,
    required this.usuario,
    required this.senha,
    this.imagem
  });
}
