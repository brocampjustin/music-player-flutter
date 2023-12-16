import 'package:flutter/material.dart';
import 'package:music_player/db/db%20functions/add_song_list.dart';
import 'package:music_player/functions/search_functions.dart';
import 'package:music_player/screens/playsong_screen/plysong_screen.dart';
import 'package:music_player/screens/screen_home/screen_hoem.dart';

import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class Favourites extends StatefulWidget {
  Favourites({super.key, required this.search});
  String search;

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: color.backGroundColor,
        child: FutureBuilder(
            future: SearchSong.favSearch(widget.search),
            builder: ((context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'No songs in favourites',
                    style: TextStyle(color: color.textColor),
                  ),
                );
              } else {
                return ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    //
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => PlayingSong(
                                    songs: snapshot.data!, songIndex: index)))
                            .then((value) {
                          setState(() {});
                        }),
                        tileColor: color.backGroundColor,
                        textColor: color.textColor,
                        iconColor: color.impColor,
                        title: Text(
                          snapshot.data![index].name,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          snapshot.data![index].artist,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                        leading: QueryArtworkWidget(
                          artworkBorder:
                              const BorderRadius.all(Radius.elliptical(10, 10)),
                          id: snapshot.data![index].songid,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Container(
                              decoration: BoxDecoration(
                                  color: color.secondaryColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.elliptical(10, 10))),
                              height: 51,
                              width: 51,
                              child: const Icon(Icons.music_note)),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              likeDbFuction(snapshot.data![index]);
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.delete,
                              color: color.impColor,
                            )),
                      );
                    },
                  ),
                );
              }
            })));
  }
}
