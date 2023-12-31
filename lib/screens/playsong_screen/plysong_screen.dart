// ignore_for_file: avoid_print

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:music_player/db/db%20functions/add_song_list.dart';
import 'package:music_player/db/song_list_model.dart';
import 'package:music_player/playlist_db/playlist_controller.dart';
import 'package:music_player/recent_db/recent_controller.dart';

import 'package:music_player/screens/screen_home/screen_hoem.dart';
import 'package:music_player/variables/varibles.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class PlayingSong extends StatefulWidget {
  PlayingSong({super.key, required this.songs, required this.songIndex});
  List<SongListModel> songs;
  int songIndex;

  @override
  State<PlayingSong> createState() => _PlayingSongState();
}

class _PlayingSongState extends State<PlayingSong> {
  Duration songDuration = const Duration();
  Duration songPossition = const Duration();
  List<int> songToPlaylist = [];

  TextEditingController playListNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isPlaying = true;
    playaudio();
    RecentDbController.addSongsToRecent(widget.songs[widget.songIndex].songid);
  }

  void playaudio() {
    RecentDbController.addSongsToRecent(widget.songs[widget.songIndex].songid);

    try {
      play.setAudioSource(AudioSource.uri(
        Uri.parse(widget.songs[widget.songIndex].uri.toString()),
        tag: MediaItem(
          // Specify a unique ID for each media item:
          id: '${widget.songs[widget.songIndex].id}',
          // Metadata to display in the notification:
          album: "${widget.songs[widget.songIndex].album}",
          title: widget.songs[widget.songIndex].name,
          artUri: Uri.parse(widget.songs[widget.songIndex].uri.toString()),
        ),
      ));

      play.play();
    } catch (d) {
      log(e);
    }

    play.durationStream.listen((d) {
      if (mounted) {
        setState(() {
          songDuration = d!;
        });
      }
    });

    play.positionStream.listen((p) {
      if (mounted) {
        setState(() {
          songPossition = p;
        });
      }
    });

    // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    play.playerStateStream.listen((PlayerState) {
      isPlaying = PlayerState.playing;
      PlayerState.processingState;
    });

    play.processingStateStream.listen((event) {
      if (event == ProcessingState.completed) {
        playnext();
      }
    });
  }

  // SongModel song;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.backGroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color.backGroundColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                  color: color.secondaryColor,
                  borderRadius: BorderRadius.circular(10)),
              height: 250,
              width: 250,
              child: QueryArtworkWidget(
                id: widget.songs[widget.songIndex].id,
                type: ArtworkType.AUDIO,
                artworkHeight: double.infinity,
                artworkWidth: double.infinity,
                nullArtworkWidget: Icon(
                  Icons.music_note,
                  color: color.impColor,
                  size: 100,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 70,
            padding: const EdgeInsets.all(25),
            child: Align(
                child: MarqueeText(
                    speed: 23,
                    text: TextSpan(
                      text: widget.songs[widget.songIndex].name,
                      style: TextStyle(
                        color: color.textColor,
                        // overflow: TextOverflow.ellipsis,
                        fontSize: 20,
                      ),
                    ))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    isShuffeling = !isShuffeling;
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.shuffle,
                    color: isShuffeling ? color.impColor : color.textColor,
                    size: 40,
                  )),
              const SizedBox(
                height: 40,
              ),
              IconButton(
                onPressed: () async {
                  likeDbFuction(widget.songs[widget.songIndex]);
                  setState(() {});
                },
                icon: Icon(
                  widget.songs[widget.songIndex].isLiked
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: widget.songs[widget.songIndex].isLiked
                      ? color.impColor
                      : color.textColor,
                  size: 40,
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
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
                                                title: const Text(
                                                    'Add new playlist'),
                                                content: TextField(
                                                  controller:
                                                      playListNameController,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              'Playlist Name'),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () async {
                                                        songToPlaylist.add(
                                                            widget.songIndex);
                                                        bool plyContain =
                                                            await PlayListController
                                                                .playlistFindDuplicates(
                                                                    playListNameController
                                                                        .text);

                                                        if (plyContain ==
                                                            false) {
                                                          PlayListController
                                                              .addPlaylist(
                                                                  playlistName:
                                                                      playListNameController
                                                                          .text,
                                                                  songIds:
                                                                      songToPlaylist);
                                                        } else {
                                                          const SnackBar(
                                                              content: Text(
                                                                  'Playlist alrady exist'));
                                                        }
                                                        // ignore: use_build_context_synchronously
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('Add')),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Cancel'))
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
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.data!.isEmpty) {
                                        return Center(
                                            child: Text(
                                          'No Playlist found',
                                          style:
                                              TextStyle(color: color.textColor),
                                        ));
                                      } else {
                                        return ListView.builder(
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (cts, index) {
                                              return ListTile(
                                                onTap: () {
                                                  PlayListController
                                                      .addSongsToPlaylist(
                                                          widget.songs[
                                                              widget.songIndex],
                                                          snapshot.data![index]
                                                              .key);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  'item added')));
                                                  Navigator.pop(context);
                                                },
                                                leading: Icon(
                                                  Icons.playlist_play,
                                                  color: color.impColor,
                                                ),
                                                title: Text(
                                                  snapshot.data![index].name,
                                                  style: TextStyle(
                                                      color: color.textColor),
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
                        });
                  },
                  icon: Icon(
                    Icons.add,
                    color: color.textColor,
                    size: 40,
                  )),
            ],
          ),
          Slider(
            min: const Duration(microseconds: 0).inSeconds.toDouble(),
            value: songPossition.inSeconds.toDouble(),
            max: songDuration.inSeconds.toDouble(),
            onChanged: (newvlue) {
              setState(() {
                if (songDuration == songPossition) {
                  widget.songIndex = widget.songIndex + 1;
                }
                changeSeconds(newvlue.toInt());
                newvlue = newvlue;
              });
            },
            activeColor: color.impColor,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDuration(songDuration),
                  style: TextStyle(color: color.textColor),
                ),
                Text(
                  formatDuration(songPossition),
                  style: TextStyle(color: color.textColor),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 0,
          ),
          SizedBox(
            width: 200,
            height: 80.1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      if (widget.songIndex == 0) {
                        widget.songIndex = widget.songs.length;
                      }
                      setState(() {
                        widget.songIndex--;
                        playaudio();
                      });
                    },
                    icon: Icon(
                      Icons.skip_previous,
                      color: color.textColor,
                      size: 55,
                    )),
                const SizedBox(
                  width: 18,
                ),
                InkWell(
                  onTap: () {
                    if (isPlaying) {
                      setState(() {
                        play.pause();
                        isPlaying = !isPlaying;
                      });
                    } else {
                      setState(() {
                        playaudio();
                        isPlaying = !isPlaying;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: color.impColor,
                        borderRadius: BorderRadius.circular(80)),
                    height: 80,
                    width: 80,
                    child: Center(
                      child: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: color.textColor,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      playnext();
                    },
                    icon: Icon(
                      Icons.skip_next,
                      color: color.textColor,
                      size: 55,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  void changeSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    play.seek(duration);
  }

  void playnext() {
    if (isShuffeling) {
      Random r = Random();
      widget.songIndex = r.nextInt(widget.songs.length);
      playaudio();
      setState(() {});
    } else if (nextSong != -1) {
      widget.songIndex = nextSong;
      nextSong = -1;
      playaudio();
    } else {
      if (widget.songIndex == widget.songs.length - 1) {
        widget.songIndex = 0;

        print(widget.songIndex);
      }
      setState(() {
        if (widget.songIndex == widget.songs.length) {
          widget.songIndex = -1;
        }
        // play.pause();
        widget.songIndex++;
        playaudio();
      });
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
