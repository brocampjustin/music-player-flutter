import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'package:music_player/colors/colors.dart';
import 'package:music_player/db/db%20functions/add_song_list.dart';
import 'package:music_player/db/song_list_model.dart';
import 'package:music_player/playlist_db/playlist_model.dart';
import 'package:music_player/recent_db/recent_db_model.dart';

import 'package:music_player/screens/screen_splash/splsh_screen.dart';

// ignore: prefer_typing_uninitialized_variables
late final songListDb;

Future<void> main() async {
  await Hive.initFlutter();

  WidgetsFlutterBinding.ensureInitialized();

  final songModelAdapter = SongListModelAdapter();
  if (!Hive.isAdapterRegistered(songModelAdapter.typeId)) {
    Hive.registerAdapter<SongListModel>(songModelAdapter);
  }

  final playListModelAdapter = PlayListModelAdapter();
  if (!Hive.isAdapterRegistered(playListModelAdapter.typeId)) {
    Hive.registerAdapter<PlayListModel>(playListModelAdapter);
  }
  final recentDbAdapter = RecentDbAdapter();
  if (!Hive.isAdapterRegistered(recentDbAdapter.typeId)) {
    Hive.registerAdapter<RecentDb>(recentDbAdapter);
  }

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(MyApp());
  });
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  MyColors color = MyColors();
  bool dbData = false;
  void dat() async {
    dbData = await dbHasData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: prefer_const_constructors

      home: const SplashScreen(),
      theme: ThemeData(primaryColor: color.backGroundColor),
    );
  }
}
