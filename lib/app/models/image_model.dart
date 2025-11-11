import 'package:hive_flutter/hive_flutter.dart';

part 'image_model.g.dart';

@HiveType(typeId: 2)
class ImageModel {
  @HiveField(0)
  String nome;

  @HiveField(1)
  String caminho;

  ImageModel({required this.nome, required this.caminho});
}
