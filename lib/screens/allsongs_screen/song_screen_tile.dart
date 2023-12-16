import 'package:flutter/material.dart';
import 'package:music_player/db/db%20functions/add_song_list.dart';
import 'package:music_player/db/song_list_model.dart';
import 'package:music_player/screens/allsongs_screen/playlist_buttom_sheet.dart';
import 'package:music_player/screens/screen_home/screen_hoem.dart';
import 'package:music_player/variables/varibles.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class SongScreenTile extends StatefulWidget {
  SongScreenTile({super.key, required this.index, required this.data});
  int index;

  List<SongListModel> data;

  @override
  State<SongScreenTile> createState() => _SongScreenTileState();
}

class _SongScreenTileState extends State<SongScreenTile> {
  // List<SongListModel> widget.data=widget.widget.data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: color.backGroundColor,
      textColor: color.textColor,
      iconColor: color.impColor,
      title: Text(
        widget.data[widget.index].name,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(widget.data[widget.index].artist),
      leading: QueryArtworkWidget(
        artworkBorder: const BorderRadius.all(Radius.elliptical(10, 10)),
        id: widget.data[widget.index].songid,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: Container(
            decoration: BoxDecoration(
                color: color.secondaryColor,
                borderRadius:
                    const BorderRadius.all(Radius.elliptical(10, 10))),
            height: 51,
            width: 51,
            child: const Icon(Icons.music_note)),
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
                    likeDbFuction(widget.data[widget.index]);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('song added to favourites')));
                  },
                  child: Text(
                    'Add to  Favourites',
                    style: TextStyle(color: color.textColor),
                  )),
              PopupMenuItem(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return PlayListButtomSheet(
                            songIndex: widget.index, songs: widget.data);
                      },
                    );
                  },
                  child: Text(
                    'Add to Playlist',
                    style: TextStyle(color: color.textColor),
                  )),
              PopupMenuItem(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: color.backGroundColor,
                          title: Text(
                            widget.data[widget.index].name,
                            style: TextStyle(color: color.textColor),
                          ),
                          content: Text(
                            '${widget.data[widget.index].info}',
                            style: TextStyle(color: color.textColor),
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    'Iformation',
                    style: TextStyle(color: color.textColor),
                  )),
              PopupMenuItem(
                  onTap: () {
                    nextSong = widget.index;
                  },
                  child: Text(
                    'play next',
                    style: TextStyle(color: color.textColor),
                  )),
              PopupMenuItem(
                  onTap: () {
                    delateSong(widget.data[widget.index]);
                    setState(() {});
                  },
                  child: Text(
                    'delete',
                    style: TextStyle(color: color.textColor),
                  ))
            ];
          }),
    );
  }
}
