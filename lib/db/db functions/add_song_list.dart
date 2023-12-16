import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_player/db/song_list_model.dart';
import 'package:music_player/variables/varibles.dart';
import 'package:on_audio_query/on_audio_query.dart';

void addSongList({required List<SongModel> songs}) async {
  final songDb = await Hive.openBox<SongListModel>('songBox');
  int id = 1;
  if (songDb.isEmpty) {
    for (SongModel song in songs) {
      songDb.add(SongListModel(
        name: song.title.toString(),
        artist: song.artist.toString(),
        uri: song.uri.toString(),
        isLiked: false,
        id: id,
        songid: song.id,
        album: song.album,
        dispalyName: song.displayName,
        info: song.data,
      ));
      id++;
    }
  } else {
    for (SongModel song in songs) {
      bool songExists =
          songDb.values.any((element) => element.songid == song.id);
      if (!songExists) {
        songDb.add(SongListModel(
          name: song.title.toString(),
          artist: song.artist.toString(),
          uri: song.uri.toString(),
          isLiked: false,
          id: id,
          songid: song.id,
          album: song.album,
          dispalyName: song.displayName,
          info: song.data,
        ));
        id++;
      }
    }
  }
}

void printSongs() async {
  final songDb = await Hive.openBox<SongListModel>('songBox');

  for (SongListModel songs in songDb.values) {
    // ignore: unnecessary_string_interpolations, avoid_print
    print('${songs.name}');
    // ignore: avoid_print
    print('${songs.isLiked}');
    // ignore: avoid_print
    print("${songs.id}");
  }
}

Future<List<SongListModel>> getSongsFromHive() async {
  final songDb = await Hive.openBox<SongListModel>('songBox');
  List<SongListModel> songList = [];
  //  songListModel  a = songListModel();

  // songList.add(a);

  for (var i = 0; i < songDb.length; i++) {
    final song = songDb.getAt(i);
    if (song != null) {
      songList.add(song);
    }
  }
  songsFormHive = songList;

  return songList;
}

void likeDbFuction(SongListModel a) async {
  final songDb = await Hive.openBox<SongListModel>('songBox');
  SongListModel song =
      songDb.values.firstWhere((song) => song.songid == a.songid);
  song.isLiked = !song.isLiked;
  songDb.put(song.key, song);
}

void positionDbFunction(SongListModel a, Duration p) async {
  final songDb = await Hive.openBox<SongListModel>('songBox');
  SongListModel song =
      songDb.values.firstWhere((song) => song.songid == a.songid);
  songDb.put(song.key, song);
}

void delateSong(SongListModel s) async {
  final songDb = await Hive.openBox<SongListModel>('songBox');
  songDb.delete(s.key);
}

void reloadDb() async {
  // ignore: avoid_print
  print('this is realosd');
  final songDb = await Hive.openBox<SongListModel>('songBox');

  List<SongListModel> songs = songDb.values.toList();
  // ignore: no_leading_underscores_for_local_identifiers
  OnAudioQuery _audioquerry = OnAudioQuery();
  List<SongModel> audio = await _audioquerry.querySongs(
    sortType: null,
    orderType: OrderType.ASC_OR_SMALLER,
    uriType: UriType.EXTERNAL,
    ignoreCase: true,
  );
  bool ch = false;

  for (int i = 0; i < audio.length; i++) {
    ch = false;
    for (int j = 0; j < songs.length; j++) {
      if (audio[i].id == songs[j].songid) {
        ch = true;
      }
    }
    if (ch == false) {
      songDb.add(SongListModel(
        artist: audio[i].artist.toString(),
        uri: audio[i].uri.toString(),
        name: audio[i].title,
        isLiked: false,
        id: 0,
        songid: audio[i].id,
        album: audio[i].album,
        dispalyName: audio[i].displayName,
        info: audio[i].data,
      ));
      // ignore: avoid_print
      print(audio[i].title);
    }
  }
}

Future<bool> dbHasData() async {
  final songDb = await Hive.openBox<SongListModel>('songBox');
  // ignore: prefer_is_empty
  if (songDb.values.length == 0) {
    return true;
  }
  return false;
}
