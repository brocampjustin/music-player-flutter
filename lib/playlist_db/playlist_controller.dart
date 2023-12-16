import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/db/song_list_model.dart';
import 'package:music_player/playlist_db/playlist_model.dart';
import 'package:music_player/variables/varibles.dart';

class PlayListController {
  static List<int> songIds = [];
  static void addPlaylist(
      {required String playlistName, required List<int> songIds}) async {
    final playBox = await Hive.openBox<PlayListModel>('playlist_db');

    playBox.add(PlayListModel(id: songIds, name: playlistName));

    // ignore: avoid_print
    print(playBox.length);
  }

  static Future<bool> playlistFindDuplicates(String playListName) async {
    final playBox = await Hive.openBox<PlayListModel>('playlist_db');
    bool contain = false;
    List<PlayListModel> ply = playBox.values.toList();

    for (int i = 0; i < ply.length; i++) {
      if (ply[i].name == playListName) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  static Future<List<PlayListModel>> getPlaylist() async {
    List<PlayListModel> playlists = [];
    final playBox = await Hive.openBox<PlayListModel>('playlist_db');

    for (int i = 0; i < playBox.length; i++) {
      playlists.add(playBox.values.toList()[i]);
    }
    return playlists;
  }

  static Future<void> deletePlaylist(int key) async {
    final playBox = await Hive.openBox<PlayListModel>('playlist_db');
    playBox.delete(key);
  }

  static void editPlaylistName(
      {required int key, required String pname}) async {
    final playBox = await Hive.openBox<PlayListModel>('playlist_db');
    final p = playBox.get(key);
    p!.name = pname;
    playBox.put(key, p);
  }

  static Future<bool> checkIfSongExist(SongListModel song, int key) async {
    bool contain = false;
    final playBox = await Hive.openBox<PlayListModel>('playlist_db');
    final ps = playBox.get(key);
    List<int> ids = ps!.id;
    for (int i = 0; i < ids.length; i++) {
      if (ids[i] == song.songid) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  static void addSongsToPlaylist(SongListModel song, int key) async {
    final playBox = await Hive.openBox<PlayListModel>('playlist_db');

    final ps = playBox.get(key);
    ps?.id.add(song.songid);
    // ignore: avoid_print
    print(ps!.id.length);
    playBox.put(key, ps);
    getSongsInsidePlaylist(key);
  }

  static Future<List<int>> getSongsInsidePlaylist(int key) async {
    final playBox = await Hive.openBox<PlayListModel>('playlist_db');
    final p = playBox.get(key);
    // ignore: avoid_print
    print('hellow ${p!.id}');
    List<int> ids = [];
    ids.addAll(p.id);
    return ids;
  }

  static void removeSongFromPlaylist(int key, int songId) async {
    final playBox = await Hive.openBox<PlayListModel>('playlist_db');
    final p = playBox.get(key);
    p!.id.remove(songId);
    // ignore: avoid_print
    print('hellow ${p.id}');
  }

  static Future<List<SongListModel>> getSongsFromPlaylistAsModel(
      int key) async {
    List<SongListModel> songs = [];
    final playBox = await Hive.openBox<PlayListModel>('playlist_db');
    final p = playBox.get(key);

    for (int i = 0; i < songsFormHive.length; i++) {
      for (int j = 0; j < p!.id.length; j++) {
        if (songsFormHive[i].songid == p.id[j]) {
          songs.add(songsFormHive[i]);
        }
      }
    }

    return songs;
  }

  static void addPlaylistFromPlayingSongScreen(
      {required String playlistName, required List<int> songIds}) async {
    final playBox = await Hive.openBox<PlayListModel>('playlist_db');
    playBox.add(PlayListModel(id: songIds, name: playlistName));

    // ignore: avoid_print
    print(playBox.length);
  }
}
