// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PetInfoAdapter extends TypeAdapter<PetInfo> {
  @override
  final int typeId = 0;

  @override
  PetInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PetInfo(
      type: fields[0] as String,
      name: fields[1] as String,
      breed: fields[2] as String,
      description: fields[3] as String,
      gender: fields[4] as String,
      size: fields[5] as String,
      weight: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PetInfo obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.breed)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.size)
      ..writeByte(6)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PetInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
