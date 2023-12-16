import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/functions/search_functions.dart';
import 'package:music_player/playlist_db/playlist_controller.dart';
import 'package:music_player/screens/playlist_screens/playlis_songs.dart';
import 'package:music_player/screens/playlist_screens/screen_playlist_screens/playlist_delete_datilog.dart';

TextEditingController playListNameController = TextEditingController();

// ignore: must_be_immutable
class PlayList extends StatefulWidget {
  PlayList({super.key, required this.search});
  // ignore: non_constant_identifier_names
  String search;

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  MyColors color = MyColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: color.impColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (ctx) => SizedBox(
                    height: 10,
                    child: AlertDialog(
                      title: const Text('Add new playlist'),
                      content: TextField(
                        controller: playListNameController,
                        decoration:
                            const InputDecoration(hintText: 'Playlist Name'),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              // ignore: prefer_is_not_empty
                              if (!playListNameController.text.isEmpty) {
                                bool contain = await PlayListController
                                    .playlistFindDuplicates(
                                        playListNameController.text);
                                if (contain == false) {
                                  PlayListController.addPlaylist(
                                      playlistName: playListNameController.text,
                                      songIds: []);
                                } else {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('playlist alrady exist')));
                                }

                                playListNameController.clear();
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                setState(() {});
                              }
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
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: color.backGroundColor,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: FutureBuilder(
            future: SearchSong.searchPlaylist(widget.search),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'no Playlist found',
                    style: TextStyle(color: color.textColor),
                  ),
                );
              }
              return ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => PlaylistSongs(
                                      id: snapshot.data![index].key,
                                    ))),
                        leading: Container(
                            decoration: BoxDecoration(
                                color: color.secondaryColor,
                                borderRadius: BorderRadius.circular(9)),
                            height: 50,
                            width: 50,
                            child: Icon(
                              Icons.playlist_play,
                              color: color.impColor,
                            )),
                        title: Text(
                          ' ${snapshot.data![index].name}',
                          style: TextStyle(color: color.textColor),
                        ),
                        trailing: PopupMenuButton(
                            color: color.backGroundColor,
                            icon: Icon(
                              Icons.more_vert,
                              color: color.textColor,
                            ),
                            itemBuilder: (ctx) {
                              return [
                                PopupMenuItem(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (i) {
                                            playListNameController.text =
                                                snapshot.data![index].name;
                                            return AlertDialog(
                                              title: const Text(
                                                  'Change Playlist name'),
                                              content: TextField(
                                                controller:
                                                    playListNameController,
                                                decoration: const InputDecoration(
                                                    hintText: 'Enter new name'),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      // ignore: prefer_is_not_empty
                                                      if (!playListNameController
                                                          .text.isEmpty) {
                                                        PlayListController
                                                            .editPlaylistName(
                                                                key: snapshot
                                                                    .data![
                                                                        index]
                                                                    .key,
                                                                pname:
                                                                    playListNameController
                                                                        .text);
                                                        playListNameController
                                                            .clear();
                                                        setState(() {});
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: const Text(
                                                        'Change name')),
                                                TextButton(
                                                    onPressed: () {
                                                      playListNameController
                                                          .clear();
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Cancel'))
                                              ],
                                            );
                                          });
                                    },
                                    child: Text(
                                      'Rename',
                                      style: TextStyle(color: color.textColor),
                                    )),
                                PopupMenuItem(
                                    onTap: () {
                                      setState(() {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return deleteDailog(
                                                songkey:
                                                    snapshot.data![index].key);
                                          },
                                        ).then((value) {
                                          setState(() {});
                                        });
                                        // PlayListController.deletePlaylist(
                                        //     snapshot.data![index].key);
                                      });
                                    },
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(color: color.textColor),
                                    )),
                              ];
                            }),
                      );
                    }),
              );
            },
          ),
        ),
      ),
    );
  }
}
