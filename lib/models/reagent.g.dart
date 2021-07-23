// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reagent.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReagentAdapter extends TypeAdapter<Reagent> {
  @override
  final int typeId = 0;

  @override
  Reagent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reagent()
      ..nameAndDescription = fields[0] as String
      ..numberONU = fields[1] as int
      ..riskClass = fields[2] as String
      ..riskNumber = fields[3] as String
      ..limit = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, Reagent obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.nameAndDescription)
      ..writeByte(1)
      ..write(obj.numberONU)
      ..writeByte(2)
      ..write(obj.riskClass)
      ..writeByte(3)
      ..write(obj.riskNumber)
      ..writeByte(4)
      ..write(obj.limit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReagentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
