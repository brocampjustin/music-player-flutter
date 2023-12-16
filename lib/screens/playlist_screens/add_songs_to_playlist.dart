import 'package:flutter/material.dart';
import 'package:music_player/db/db%20functions/add_song_list.dart';
import 'package:music_player/playlist_db/playlist_controller.dart';
import 'package:music_player/screens/screen_home/screen_hoem.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class AddSongsToPlayList extends StatefulWidget {
  AddSongsToPlayList({super.key, required this.id});
  int id;

  @override
  State<AddSongsToPlayList> createState() => _AddSongsToPlayListState();
}

class _AddSongsToPlayListState extends State<AddSongsToPlayList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Songs'),
        backgroundColor: color.backGroundColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: color.textColor,
            )),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: color.backGroundColor,
        child: FutureBuilder(
            future: getSongsFromHive(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError || snapshot.data == null) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('no data'),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (ctx, index) {
                      return ListTile(
                          title: Text(
                            '${snapshot.data?[index].name}',
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: color.textColor),
                          ),
                          leading: QueryArtworkWidget(
                            id: snapshot.data![index].songid,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Icon(
                              Icons.music_note,
                              color: color.textColor,
                            ),
                          ),
                          trailing: PlayListController.songIds
                                  .contains(snapshot.data![index].songid)
                              ? IconButton(
                                  onPressed: () async {
                                    PlayListController.removeSongFromPlaylist(
                                        widget.id,
                                        snapshot.data![index].songid);
                                    PlayListController.songIds =
                                        await PlayListController
                                            .getSongsInsidePlaylist(widget.id);
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.remove,
                                    color: color.textColor,
                                  ))
                              : IconButton(
                                  onPressed: () async {
                                    PlayListController.addSongsToPlaylist(
                                        snapshot.data![index], widget.id);
                                    PlayListController.songIds =
                                        await PlayListController
                                            .getSongsInsidePlaylist(widget.id);
                                    setState(() {});
                                  },
                                  icon: Icon(Icons.add, color: color.textColor),
                                ));
                    });
              }
            }),
      ),
    );
  }
}
