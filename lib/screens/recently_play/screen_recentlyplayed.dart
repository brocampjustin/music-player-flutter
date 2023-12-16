import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/db/db%20functions/add_song_list.dart';
import 'package:music_player/db/song_list_model.dart';
import 'package:music_player/functions/search_functions.dart';
import 'package:music_player/screens/playsong_screen/plysong_screen.dart';

// ignore: must_be_immutable
class RecentleyPlayed extends StatefulWidget {
  RecentleyPlayed({super.key, required this.search});
  String search;

  @override
  State<RecentleyPlayed> createState() => _RecentleyPlayedState();
}

class _RecentleyPlayedState extends State<RecentleyPlayed> {
  @override
  void initState() {
    super.initState();

    getSongsFromHive();
  }

  MyColors color = MyColors();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.backGroundColor,
      child: FutureBuilder(
        future: SearchSong.recentSearch(widget.search),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'no recently songs ',
                style: TextStyle(color: color.textColor),
              ),
            );
          } else {
            List<SongListModel> rData = [];
            rData.addAll(snapshot.data!.reversed);
            return ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: ListView.builder(
                  itemCount: rData.length,
                  itemBuilder: (context, index) {
                    final data = rData[index];
                    return ListTile(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PlayingSong(songs: rData, songIndex: index))),
                      tileColor: color.backGroundColor,
                      textColor: color.textColor,
                      iconColor: color.impColor,
                      title: Text(
                        data.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(data.artist),
                      leading: Container(
                          decoration: BoxDecoration(
                              color: color.secondaryColor,
                              borderRadius: const BorderRadius.all(
                                  Radius.elliptical(10, 10))),
                          height: 51,
                          width: 51,
                          child: const Icon(Icons.music_note)),
                    );
                  }),
            );
          }
        },
      ),
    );
  }
}
