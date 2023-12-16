import 'package:flutter/material.dart';
import 'package:music_player/screens/screen_home/screen_hoem.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: color.backGroundColor,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: color.backGroundColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '''Introducing our innovative music player app, designed to revolutionize your listening experience. Our app combines cutting-edge technology with an intuitive interface,  offering seamless navigation through your music library. Enjoy personalized playlists, superiorsound quality, and effortless organization of your favorite tracks. Whether you're a music enthusiast or a casual listener, our app caters to your every need. Elevate your music journey with our feature-rich, user-centric music player app''',
            style: TextStyle(color: color.textColor, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
