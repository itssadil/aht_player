import 'package:ahtplayer/providers/favoriteProvider.dart';
import 'package:ahtplayer/providers/homeProvider.dart';
import 'package:ahtplayer/providers/playPauseProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/isSearchVisibleProvider.dart';
import 'splash.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => IsSearchVisibleProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => PlayPause()),
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
      home: Splash(),
    );
  }
}
