import 'package:ahtplayer/pages/playlistPage/playlist.dart';
import 'package:ahtplayer/pages/searcgPage/searchPage.dart';
import 'package:ahtplayer/providers/homeProvider.dart';
import 'package:ahtplayer/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

import '../../widgets/footerPlaying.dart';
import '../playlistPage/favorite.dart';
import 'subPages/musicCat.dart';
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: title(appTitle: 'AHT Player'),
          centerTitle: true,
          foregroundColor: Colors.lightBlue,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(_audioPlayer),
                    ));
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                MusicCat(),
                Consumer<HomeProvider>(
                  builder: (context, homeTab, child) {
                    switch (homeTab.homeTab) {
                      case 1:
                        return Favorite(_audioPlayer);
                      case 2:
                        return Playlist(_audioPlayer);
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
      ),
    );
  }
}
