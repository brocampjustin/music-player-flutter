import 'package:hive_flutter/hive_flutter.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 1)
class PlayListModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<int> id;

  PlayListModel({required this.id, required this.name});
}
