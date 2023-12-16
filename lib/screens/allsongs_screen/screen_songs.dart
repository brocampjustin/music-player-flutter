import 'package:flutter/material.dart';

import 'package:music_player/colors/colors.dart';
import 'package:music_player/db/db%20functions/add_song_list.dart';
import 'package:music_player/db/song_list_model.dart';

import 'package:music_player/functions/search_functions.dart';
import 'package:music_player/screens/allsongs_screen/song_screen_tile.dart';

import 'package:music_player/screens/playsong_screen/plysong_screen.dart';
import 'package:music_player/screens/screen_home/screen_hoem.dart';


class ScreenSongs extends StatefulWidget {
  const ScreenSongs({super.key, required String search});

  @override
  State<ScreenSongs> createState() => _ScreenSongsState();
}

bool isPlaying = false;

class _ScreenSongsState extends State<ScreenSongs> {
  String songUri = '';
  MyColors color = MyColors();

  @override
  void initState() {
    super.initState();
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color.backGroundColor,
        body: RefreshIndicator(
          color: color.impColor,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 3));
            reloadDb();
            setState(() {});
          },
          child: FutureBuilder<List<SongListModel>>(
              future: SearchSong.setAudioSearch(searchController.text),
              builder: (ctx, item) {
                if (item.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (item.data!.isEmpty) {
                  return Center(
                      child: Text(
                    'No Songs Fond',
                    style: TextStyle(color: color.textColor),
                  ));
                } else {
                  return ScrollConfiguration(
                    behavior:
                        const ScrollBehavior().copyWith(overscroll: false),
                    child: ListView.builder(
                        itemCount: item.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // resantlyPlayed.add(item.data![index]);
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                // return PlayList();

                                return PlayingSong(
                                  songs: item.data!,
                                  songIndex: index,
                                );
                              }));
                            },
                            child:
                                SongScreenTile(index: index, data: item.data!),
                          );
                        }),
                  );
                }
              }),
        ));
    // );
  }
}
