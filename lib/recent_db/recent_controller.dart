import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/db/db%20functions/add_song_list.dart';
import 'package:music_player/db/song_list_model.dart';
import 'package:music_player/recent_db/recent_db_model.dart';

class RecentDbController {






  static void addSongsToRecent(int n) async {
 
  final recentBox = await Hive.openBox<RecentDb>('recent_db');
  List<RecentDb> recentList = recentBox.values.toList();

  for (int i = 0; i < recentList.length; i++) {
    if (recentList[i].id == n) {
      
      recentBox.delete(recentList[i].key); // Deleting existing ID
      break;
    }
  }

 

  
  recentBox.add(RecentDb(id: n));
}






  // static void addSongsToRcent(int n) async {
  //   bool b = false;
  //   List<RecentDb> s = [];
  //   int rs = 0;
  //   final r = await Hive.openBox<RecentDb>('recent_db');
  //   s.addAll(r.values);

  //   // ignore: avoid_print
  //   print('length he ${s.length}');
  //   for (int i = 0; i < s.length; i++) {
  //     if (s[i].id == n) {
  //       b = true;
  //       rs = i;
  //       break;
  //     }
  //   }

  //   if (b == true) {
  //     deletSongFormRcent(s[rs]);
  //   }

  //   r.add(RecentDb(id: n));
  // }

  static void deletSongFormRcent(RecentDb rs) async {
    final r = await Hive.openBox<RecentDb>('recent_db');

    r.delete(rs.key);
  }

  static Future<List<SongListModel>> getSongsFromRcent() async {
    final recent = await Hive.openBox<RecentDb>('recent_db');
    List<SongListModel> songs = [];
    List<SongListModel> mysong = [];
    List<RecentDb> recentTempList = [];
    recentTempList.addAll(recent.values);
    mysong = await getSongsFromHive();
    // ignore: avoid_print
    print(recentTempList.length);

    // for (int i = 0; i < mysong.length; i++) {
    //   for (int j = 0; j < recentTempList.length; j++) {
    //     if (mysong[i].songid == recentTempList[j].id) {
    //       songs.add(mysong[i]);
    //     }
    //   }
    // }

    for(int j = 0; j < recentTempList.length; j++){
      for(int i = 0; i < mysong.length; i++){
        if (mysong[i].songid == recentTempList[j].id) {
          songs.add(mysong[i]);
        }
        

      }
    }

    return songs;
  }
}
