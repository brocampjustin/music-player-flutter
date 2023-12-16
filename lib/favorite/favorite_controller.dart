import 'package:music_player/db/db%20functions/add_song_list.dart';
import 'package:music_player/db/song_list_model.dart';

 class FavouritesController{
  static Future<List<SongListModel>> favList() async {
    List<SongListModel> songs = await getSongsFromHive();
    List<SongListModel> favSongs = songs.where((song) {
      return song.isLiked == true;
    }).toList() ;
    return favSongs;
  }


 }

