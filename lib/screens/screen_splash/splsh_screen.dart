import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:music_player/screens/screen_home/screen_hoem.dart';
import 'package:music_player/song_fetch_functions/fetch_audio.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FectchSongs.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.backGroundColor,
      body: AnimatedSplashScreen(
        splash: SizedBox(
          width: 300,
          height: 200,
          child: Image.asset(
            'assets/musicflow-high-resolution-logo-transparent.png',
          ),
        ),
        nextScreen: const ScreenHome(),
        splashTransition: SplashTransition.scaleTransition,
        backgroundColor: color.backGroundColor,
        duration: 3000,
      ),
    );
  }
}
