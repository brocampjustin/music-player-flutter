import 'package:hive_flutter/hive_flutter.dart';
part 'recent_db_model.g.dart';

@HiveType(typeId: 2)
class RecentDb extends HiveObject {
  @HiveField(0)
  int id;
  RecentDb({required this.id});
}
