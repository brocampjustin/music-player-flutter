// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongListModelAdapter extends TypeAdapter<SongListModel> {
  @override
  final int typeId = 0;

  @override
  SongListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongListModel(
      artist: fields[0] as String,
      uri: fields[2] as String,
      name: fields[1] as String,
      isLiked: fields[3] as bool,
      id: fields[4] as int,
      songid: fields[5] as dynamic,
      album: fields[6] as dynamic,
      dispalyName: fields[7] as dynamic,
      info: fields[8] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, SongListModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.artist)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.uri)
      ..writeByte(3)
      ..write(obj.isLiked)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.songid)
      ..writeByte(6)
      ..write(obj.album)
      ..writeByte(7)
      ..write(obj.dispalyName)
      ..writeByte(8)
      ..write(obj.info);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
