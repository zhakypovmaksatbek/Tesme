// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zikir_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ZikirModelAdapter extends TypeAdapter<ZikirModel> {
  @override
  final int typeId = 1;

  @override
  ZikirModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ZikirModel(
      zikirID: fields[0] as String,
      zikirName: fields[1] as String,
      zikirArabic: fields[2] as String,
      zikirCount: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ZikirModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.zikirID)
      ..writeByte(1)
      ..write(obj.zikirName)
      ..writeByte(2)
      ..write(obj.zikirArabic)
      ..writeByte(3)
      ..write(obj.zikirCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZikirModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
