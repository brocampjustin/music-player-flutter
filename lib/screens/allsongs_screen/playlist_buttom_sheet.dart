import 'package:flutter/material.dart';
import 'package:music_player/db/song_list_model.dart';
import 'package:music_player/playlist_db/playlist_controller.dart';
import 'package:music_player/screens/screen_home/screen_hoem.dart';

// ignore: must_be_immutable
class PlayListButtomSheet extends StatefulWidget {
  PlayListButtomSheet({super.key, required this.songIndex,required this.songs});
  int songIndex;
  List<SongListModel> songs = [];

  @override
  State<PlayListButtomSheet> createState() => PlayListButtomSheetState();
}

class PlayListButtomSheetState extends State<PlayListButtomSheet> {
  TextEditingController playListNameController = TextEditingController();
  List<int> songToPlaylist = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: color.backGroundColor,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (ctx) => SizedBox(
                        height: 10,
                        child: AlertDialog(
                          title: const Text('Add new playlist'),
                          content: TextField(
                            controller: playListNameController,
                            decoration: const InputDecoration(
                                hintText: 'Playlist Name'),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  songToPlaylist.add(widget.songIndex);
                                  bool plyContain = await PlayListController
                                      .playlistFindDuplicates(
                                          playListNameController.text);

                                  if (plyContain == false) {
                                    PlayListController.addPlaylist(
                                        playlistName:
                                            playListNameController.text,
                                        songIds: songToPlaylist);
                                  } else {
                                    const SnackBar(
                                        content: Text('Playlist alrady exist'));
                                  }
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                },
                                child: const Text('Add')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'))
                          ],
                        ),
                      ));
            },
            leading: Icon(
              Icons.playlist_add,
              color: color.impColor,
            ),
            title: Text(
              'Create Playlist',
              style: TextStyle(color: color.textColor),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: PlayListController.getPlaylist(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data!.isEmpty) {
                  return Center(
                      child: Text(
                    'No Playlist found',
                    style: TextStyle(color: color.textColor),
                  ));
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (cts, index) {
                        return ListTile(
                          onTap: () {
                            PlayListController.addSongsToPlaylist(
                                widget.songs[widget.songIndex],
                                snapshot.data![index].key);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('item added')));
                            Navigator.pop(context);
                          },
                          leading: Icon(
                            Icons.playlist_play,
                            color: color.impColor,
                          ),
                          title: Text(
                            snapshot.data![index].name,
                            style: TextStyle(color: color.textColor),
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
