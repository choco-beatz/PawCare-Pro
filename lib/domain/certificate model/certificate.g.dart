// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CertificateAdapter extends TypeAdapter<Certificate> {
  @override
  final int typeId = 2;
  @override
  Certificate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Certificate(
      name: fields[0] as String,
      file: fields[1] as String,
      idate: fields[2] as String,
      edate: fields[3] as String,
      id: fields[5] as int,
      pet: (fields[4] as List?)?.cast<PetInfo>(),
    );
  }

  @override
  void write(BinaryWriter writer, Certificate obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.file)
      ..writeByte(2)
      ..write(obj.idate)
      ..writeByte(3)
      ..write(obj.edate)
      ..writeByte(4)
      ..write(obj.pet)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CertificateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
