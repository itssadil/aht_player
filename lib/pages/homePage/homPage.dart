import 'package:ahtplayer/providers/homeProvider.dart';
import 'package:ahtplayer/providers/isSearchVisibleProvider.dart';
import 'package:ahtplayer/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import 'subPages/favorite.dart';
import 'subPages/footerPlaying.dart';
import 'subPages/musicCat.dart';
import 'subPages/search.dart';
import 'subPages/songs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AudioPlayer _audioPlayer = new AudioPlayer();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title(appTitle: 'AHT Player'),
        centerTitle: true,
        foregroundColor: Colors.lightBlue,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Consumer<IsSearchVisibleProvider>(
            builder: (context, changeSearchVisible, child) {
              return IconButton(
                onPressed: () => changeSearchVisible.changeSearchVisible(),
                icon: Icon(Icons.search),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Consumer<IsSearchVisibleProvider>(
                builder: (context, isSearchVisible, child) {
                  return Visibility(
                    visible: !isSearchVisible.isSearchVisible,
                    child: MusicCat(),
                  );
                },
              ),
              Consumer<IsSearchVisibleProvider>(
                builder: (context, isSearchVisible, child) {
                  return Visibility(
                    visible: isSearchVisible.isSearchVisible,
                    child: Search(),
                  );
                },
              ),
              Consumer<HomeProvider>(
                builder: (context, homeTab, child) {
                  switch (homeTab.homeTab) {
                    case 1:
                      return Favorite();
                    default:
                      return Songs(_audioPlayer);
                  }
                },
              ),
              // SizedBox(height: 20),
            ],
          ),
          FooterPlayingSection(_audioPlayer),
        ],
      ),
    );
  }
}
