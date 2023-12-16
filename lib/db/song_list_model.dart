import 'package:hive/hive.dart';
part 'song_list_model.g.dart';

@HiveType(typeId: 0)
class SongListModel extends HiveObject {
  @HiveField(0)
  String artist;
  @HiveField(1)
  String name;
  @HiveField(2)
  String uri;

  @HiveField(3)
  bool isLiked;
  @HiveField(4)
  int id;
  @HiveField(5)
  // ignore: prefer_typing_uninitialized_variables
  final songid;
  @HiveField(6)
  // ignore: prefer_typing_uninitialized_variables
  final album;
  @HiveField(7)
  // ignore: prefer_typing_uninitialized_variables
  final dispalyName;
  @HiveField(8)
  // ignore: prefer_typing_uninitialized_variables
  final info;
  


  SongListModel(
      {required this.artist,
      required this.uri,
      required this.name,
      required this.isLiked,
      required this.id,
      required this.songid,
      required this.album,
      required this.dispalyName,
      required this.info,
      });
}
