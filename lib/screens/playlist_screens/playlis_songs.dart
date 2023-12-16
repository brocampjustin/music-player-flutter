import 'package:flutter/material.dart';
import 'package:music_player/playlist_db/playlist_controller.dart';
import 'package:music_player/screens/playlist_screens/add_songs_to_playlist.dart';
import 'package:music_player/screens/playsong_screen/plysong_screen.dart';
import 'package:music_player/screens/screen_home/screen_hoem.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class PlaylistSongs extends StatefulWidget {
  PlaylistSongs({super.key, required this.id});
  int id;

  @override
  State<PlaylistSongs> createState() => _PlaylistScreensState();
}

class _PlaylistScreensState extends State<PlaylistSongs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return AddSongsToPlayList(
              id: widget.id,
            );
          })).then((value) {
            setState(() {});
          });
        },
        backgroundColor: color.impColor,
        child: Icon(
          Icons.add,
          color: color.textColor,
        ),
      ),
      appBar: AppBar(
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
          future: PlayListController.getSongsFromPlaylistAsModel(widget.id),
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
              return ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 15,
                    );
                  },
                  itemCount: snapshot.data!.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PlayingSong(
                                songs: snapshot.data!, songIndex: index)));
                      },
                      leading: Container(
                        decoration: BoxDecoration(
                            color: color.secondaryColor,
                            borderRadius: BorderRadius.circular(9)),
                        width: 50,
                        height: 50,
                        child: QueryArtworkWidget(
                          id: snapshot.data![index].songid,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Icon(
                            Icons.music_note,
                            color: color.impColor,
                          ),
                        ),
                      ),
                      title: Text(
                        snapshot.data![index].name,
                        style: TextStyle(
                            color: color.textColor,
                            overflow: TextOverflow.ellipsis),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            PlayListController.removeSongFromPlaylist(
                                widget.id, snapshot.data![index].songid);
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.delete,
                            color: color.impColor,
                          )),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
