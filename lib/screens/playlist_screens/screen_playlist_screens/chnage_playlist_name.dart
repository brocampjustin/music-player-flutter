// import 'package:flutter/material.dart';
// import 'package:music_player/playlist_db/playlist_controller.dart';
// import 'package:music_player/screens/playlist_screens/screen_playlist_screens/screen_playlist.dart';

// Future<dynamic> playlistRename() async {
//   int context;

//   return showDialog(
//       context: context,
//       builder: (i) {
//         return AlertDialog(
//           title: const Text('Change Playlist name'),
//           content: TextField(
//             controller: playListNameController,
//             decoration: const InputDecoration(hintText: 'Enter new name'),
//           ),
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   // ignore: prefer_is_not_empty
//                   if (!playListNameController.text.isEmpty) {
//                     PlayListController.editPlaylistName(
//                         key: snapshot.data![index].key,
//                         pname: playListNameController.text);
//                     playListNameController.clear();
//                     setState(() {});
//                     Navigator.pop(context);
//                   }
//                 },
//                 child: const Text('Change name')),
//             TextButton(
//                 onPressed: () {
//                   playListNameController.clear();
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Cancel'))
//           ],
//         );
//       });
// }
