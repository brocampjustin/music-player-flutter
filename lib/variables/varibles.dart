import 'package:just_audio/just_audio.dart';
import 'package:music_player/db/song_list_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

bool isPlaying = false;
final play = AudioPlayer();
bool isShuffeling = false;
List<SongModel> resantlyPlayed = [];
List<SongListModel> songsFormHive = [];
int nextSong=-1;
