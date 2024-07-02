// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificates.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CertificatesAdapter extends TypeAdapter<Certificates> {
  @override
  final int typeId = 2;

  @override
  Certificates read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Certificates(
      name: fields[0] as String,
      file: fields[1] as String,
      idate: fields[2] as String,
      edate: fields[3] as String,
      id: fields[5] as int,
      petId: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Certificates obj) {
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
      ..write(obj.petId)
      ..writeByte(5)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CertificatesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
