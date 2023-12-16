// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentDbAdapter extends TypeAdapter<RecentDb> {
  @override
  final int typeId = 2;

  @override
  RecentDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentDb(
      id: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RecentDb obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentDbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
