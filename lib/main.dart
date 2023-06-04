import 'package:ahtplayer/providers/allSongsListProvider.dart';
import 'package:ahtplayer/providers/durPosProvider.dart';
import 'package:ahtplayer/providers/favoriteProvider.dart';
import 'package:ahtplayer/providers/footerPlayingProvider.dart';
import 'package:ahtplayer/providers/homeProvider.dart';
import 'package:ahtplayer/providers/isLoopingProvider.dart';
import 'package:ahtplayer/providers/isSuffleProvider.dart';
import 'package:ahtplayer/providers/musicPlayerTitleProvider.dart';
import 'package:ahtplayer/providers/playPauseProvider.dart';
import 'package:ahtplayer/providers/searchValueProvider.dart';
import 'package:ahtplayer/providers/timerVisibleProvider.dart';
import 'package:ahtplayer/providers/visibleRefreshProvider.dart';
import 'package:ahtplayer/providers/volumeSetProvider.dart';
import 'package:ahtplayer/splash.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';

import 'providers/visiblePlaylistSongsProvider.dart';

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId:
        'ahtplayer.adilhussain.me.ahtplayer.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => PlayPause()),
        ChangeNotifierProvider(create: (_) => DurPosProvider()),
        ChangeNotifierProvider(create: (_) => IsSongLooping()),
        ChangeNotifierProvider(create: (_) => IsSongShuffle()),
        ChangeNotifierProvider(create: (_) => MusicPlayerTitle()),
        ChangeNotifierProvider(create: (_) => TimerVisible()),
        ChangeNotifierProvider(create: (_) => VolumeSet()),
        ChangeNotifierProvider(create: (_) => FooterPlayingProvider()),
        ChangeNotifierProvider(create: (_) => AllSongsList()),
        ChangeNotifierProvider(create: (_) => VisibleRefreshProvider()),
        ChangeNotifierProvider(create: (_) => VisiblePlaylistSongs()),
        ChangeNotifierProvider(create: (_) => songValueList()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AHT Player',

      // home: SearchPage(),
      home: Splash(),
    );
  }
}
