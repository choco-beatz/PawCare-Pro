// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DocumentsAdapter extends TypeAdapter<Documents> {
  @override
  final int typeId = 5;

  @override
  Documents read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Documents(
      dname: fields[0] as String,
      dfile: fields[1] as String,
      didate: fields[2] as String,
      dedate: fields[3] as String,
      did: fields[5] as int,
      petID: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Documents obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.dname)
      ..writeByte(1)
      ..write(obj.dfile)
      ..writeByte(2)
      ..write(obj.didate)
      ..writeByte(3)
      ..write(obj.dedate)
      ..writeByte(4)
      ..write(obj.petID)
      ..writeByte(5)
      ..write(obj.did);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
