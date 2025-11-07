// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PasswordModelAdapter extends TypeAdapter<PasswordModel> {
  @override
  final int typeId = 0;

  @override
  PasswordModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PasswordModel(
      site: fields[0] as String,
      usuario: fields[1] as String,
      senha: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PasswordModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.site)
      ..writeByte(1)
      ..write(obj.usuario)
      ..writeByte(2)
      ..write(obj.senha);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasswordModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
