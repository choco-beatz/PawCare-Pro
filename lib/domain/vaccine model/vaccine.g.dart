// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccine.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VaccineAdapter extends TypeAdapter<Vaccine> {
  @override
  final int typeId = 3;

  @override
  Vaccine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vaccine(
      name: fields[0] as String,
      idate: fields[1] as String,
      edate: fields[2] as String,
      id: fields[4] as int,
      pet: (fields[3] as List?)?.cast<PetInfo>(),
    );
  }

  @override
  void write(BinaryWriter writer, Vaccine obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.idate)
      ..writeByte(2)
      ..write(obj.edate)
      ..writeByte(3)
      ..write(obj.pet)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VaccineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
