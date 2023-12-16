
import 'package:music_player/db/db%20functions/add_song_list.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class FectchSongs{
 static   List<SongModel> songs = [];
  static  OnAudioQuery audioQuery = OnAudioQuery();
    static void requestPermission() async {
    final permissionState = await Permission.storage.request();
    if (permissionState.isGranted) {
      getAudio();
    } else {
      requestPermission();
    }
  }


  
 static  Future<List<SongModel>> getAudio() async {
    List<SongModel> fetchedSongs = await audioQuery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    songs = fetchedSongs;
    addToDb(songs: songs);
    return fetchedSongs;
  }
   
static void addToDb({required List<SongModel> songs}) async {
  // final songDb = await Hive.openBox('songBox');

  addSongList(songs: songs);
  
}



}