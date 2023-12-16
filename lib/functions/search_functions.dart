import 'package:music_player/db/db%20functions/add_song_list.dart';
import 'package:music_player/db/song_list_model.dart';
import 'package:music_player/favorite/favorite_controller.dart';
import 'package:music_player/playlist_db/playlist_controller.dart';
import 'package:music_player/playlist_db/playlist_model.dart';
import 'package:music_player/recent_db/recent_controller.dart';
import 'package:music_player/screens/screen_home/screen_hoem.dart';

class SearchSong {
  static Future<List<SongListModel>> setAudioSearch(String query) async {
    if (query.isEmpty) {
      // ignore: avoid_print
      print('omg $query');
      return getSongsFromHive();
    } else {
      List<SongListModel> fetchedSongs = await getSongsFromHive();
      List<SongListModel> searchedSongs = fetchedSongs.where((song) {
        return song.name
                .toLowerCase()
                .trim()
                .contains(searchController.text.toLowerCase()) ||
            song.artist
                .toLowerCase()
                .trim()
                .contains(searchController.text.toLowerCase());
      }).toList();

      return searchedSongs;
    }
  }

  static Future<List<PlayListModel>> searchPlaylist(String query) async {
    if (query.isEmpty) {
      // ignore: avoid_print
      print('omg $query');
      return PlayListController.getPlaylist();
    } else {
      List<PlayListModel> fetchedSongs = await PlayListController.getPlaylist();

      List<PlayListModel> plyalists = fetchedSongs.where((song) {
        return song.name
            .toLowerCase()
            .trim()
            .contains(searchController.text.toLowerCase());
      }).toList();

      return plyalists;
    }
  }

  static Future<List<SongListModel>> favSearch(String query) async {
    if (query.isEmpty) {
      // ignore: avoid_print
      print('omg $query');
      return FavouritesController.favList();
    } else {
      List<SongListModel> fetchedSongs = await FavouritesController.favList();
      List<SongListModel> searchedSongs = fetchedSongs.where((song) {
        return song.name
                .toLowerCase()
                .trim()
                .contains(searchController.text.toLowerCase()) ||
            song.artist
                .toLowerCase()
                .trim()
                .contains(searchController.text.toLowerCase());
      }).toList();

      return searchedSongs;
    }
  }

  static Future<List<SongListModel>> recentSearch(String query) async {
    if (query.isEmpty) {
      // ignore: avoid_print
      print('omg $query');
      return RecentDbController.getSongsFromRcent();
    } else {
      List<SongListModel> fetchedSongs =
          await RecentDbController.getSongsFromRcent();
      List<SongListModel> searchedSongs = fetchedSongs.where((song) {
        return song.name
                .toLowerCase()
                .trim()
                .contains(searchController.text.toLowerCase()) ||
            song.artist
                .toLowerCase()
                .trim()
                .contains(searchController.text.toLowerCase());
      }).toList();

      return searchedSongs;
    }
  }
}
