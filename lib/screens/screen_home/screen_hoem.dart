// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/colors/colors.dart';
import 'package:music_player/screens/drawer_screens/drawer.dart';
import 'package:music_player/screens/favourite_screen/screen_favourites.dart';
import 'package:music_player/screens/allsongs_screen/screen_songs.dart';
import 'package:music_player/screens/playlist_screens/screen_playlist_screens/screen_playlist.dart';
import 'package:music_player/screens/recently_play/screen_recentlyplayed.dart';

MyColors color = MyColors();

TextEditingController searchController = TextEditingController();

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  bool _isSearching = false;
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: color.backGroundColor,
          title: _isSearching
              ? ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      // ignore: avoid_print
                      print(value);
                      searchText = value;
                      setState(() {});
                    },
                    style: TextStyle(color: color.textColor),
                    // Implement your TextField properties here
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: color.secondaryColor,
                      hintText: 'Search',
                      labelStyle: TextStyle(color: color.textColor),
                      hintStyle: TextStyle(color: color.textColor),
                      border: InputBorder.none,
                    ),
                  ),
                )
              : Row(
                  children: [
                    Container(
                      width: 10,
                    ),

                    SizedBox(
                      width: 180,
                      height: 80,
                      child: Image.asset(
                        'assets/musicflow-high-resolution-logo-transparent.png',
                        color: color.textColor,
                      ),
                    )
                    // Text(
                    //   'MusicPlayer',
                    //   style: TextStyle(fontSize: 28, color: color.textColor),
                    // ),
                  ],
                ),
          actions: [
            _isSearching
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isSearching = false;
                        searchController.clear();
                      });
                    },
                    icon: const Icon(Icons.close),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _isSearching = true;
                      });
                    },
                    icon: const Icon(Icons.search),
                  ),
            Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  size: 30,
                ),
              );
            }),
            const SizedBox(
              width: 12,
            )
          ],
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: color.impColor,
            indicatorWeight: 4,
            labelStyle: const TextStyle(fontSize: 18),
            tabs: const [
              Tab(
                text: 'Songs',
              ),
              Tab(
                text: 'Playlist',
              ),
              Tab(
                text: 'Favourites ',
              ),
              Tab(
                text: 'Recently Played',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ScreenSongs(
              search: searchText,
            ),
            PlayList(
              search: searchText,
            ),
            Favourites(search: searchText),
            RecentleyPlayed(search: searchText),

            // Ensure there's a corresponding child for each tab
          ],
        ),
        drawer: Drawer(
          width: 300,
          backgroundColor: color.backGroundColor,
          child: const DrawerScreen(),
        ),
      ),
    );
  }
}
