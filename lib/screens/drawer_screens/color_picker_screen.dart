// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// import 'package:music_player/screens/screen_hoem.dart';

// class ColorPickerScreen extends StatefulWidget {
//   const ColorPickerScreen({super.key});

//   @override
//   State<ColorPickerScreen> createState() => _ColorPickerScreenState();
// }

// class _ColorPickerScreenState extends State<ColorPickerScreen> {
//   Color myColor = Colors.white;
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     print('this is form dispose method');
   
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: color.backGroundColor,
//         title: const Text('Pick Color'),
//       ),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         color: color.backGroundColor,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: const Text('Pick Color'),
//                           content: impBuildColorPcker(),
//                           actions: [
//                             TextButton(
//                                 onPressed: () {
//                                   setState(() {});
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Text('Change Color'))
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: color.textColor,
//                         border: Border.all(color: Colors.blue, width: 3)),
//                     height: 90,
//                     width: 90,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: const Text('Pick Color'),
//                           content: texBuildColorPcker(),
//                           actions: [
//                             TextButton(
//                                 onPressed: () {
//                                   setState(() {});
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Text('Change Color'))
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: color.impColor,
//                         border: Border.all(color: Colors.blue, width: 3)),
//                     height: 90,
//                     width: 90,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: const Text('Pick Color'),
//                           content: secBuildColorPcker(),
//                           actions: [
//                             TextButton(
//                                 onPressed: () {
//                                   setState(() {});
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Text('Change Color'))
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: color.secondaryColor,
//                         border: Border.all(color: Colors.blue, width: 3)),
//                     height: 90,
//                     width: 90,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: const Text('Pick Color'),
//                           content: backBuildColorPcker(),
//                           actions: [
//                             TextButton(
//                                 onPressed: () {
//                                   setState(() {});
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Text('Change Color'))
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: color.backGroundColor,
//                         border: Border.all(color: Colors.blue, width: 3)),
//                     height: 90,
//                     width: 90,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   impBuildColorPcker() async {
//     return ColorPicker(
//       pickerColor: myColor,
//       onColorChanged: (value) {
//         color.impColor = value;
//       },
//     );
//   }

//   backBuildColorPcker() {
//     return ColorPicker(
//       pickerColor: myColor,
//       onColorChanged: (value) {
//         color.backGroundColor = value;
//       },
//     );
//   }

//   secBuildColorPcker() {
//     return ColorPicker(
//       pickerColor: myColor,
//       onColorChanged: (value) {
//         color.secondaryColor = value;
//       },
//     );
//   }

//   texBuildColorPcker() {
//     return ColorPicker(
//       pickerColor: myColor,
//       onColorChanged: (value) {
//         color.textColor = value;
//       },
//     );
//   }
// }
