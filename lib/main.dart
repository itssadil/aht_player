import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/providers/isSearchVisibleProvider.dart';
import 'splash.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IsSearchVisibleProvider()),
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
