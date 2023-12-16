// import 'dart:math';

// import 'package:just_audio/just_audio.dart';
// import 'package:just_audio_background/just_audio_background.dart';
// import 'package:music_player/variables/varibles.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class AudioFuctions{
//   static late  int songIndex;
  
//   static   void playaudio({required List<SongModel> songs}) {
//     try {
//       play.setAudioSource(AudioSource.uri(
//         Uri.parse(songs[songIndex].uri.toString()),
//         tag: MediaItem(
//           // Specify a unique ID for each media item:
//           id: '${songs[songIndex].id}',
//           // Metadata to display in the notification:
//           album: "${songs[songIndex].album}",
//           title: "${songs[songIndex].title}",
//           artUri: Uri.parse('${songs[songIndex].uri.toString()}'),
//         ),
//       ));

//       play.play();
//     } catch (d) {
//       log(e);
//     }

//     play.durationStream.listen((d) {
//      if(mounted){
//           setState(() {
//         songDuration = d!;
//       });
//      }
//     });

//     play.positionStream.listen((p) {
//       if(mounted){
//         setState(() {
//         songPossition = p;
//       });
//       }
//     });
//   }
// }