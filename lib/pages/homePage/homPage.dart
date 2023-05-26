import 'package:ahtplayer/pages/widgets/title.dart';
import 'package:flutter/material.dart';

import 'subPages/musicCat.dart';
import 'subPages/musicList.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title(appTitle: 'AHT Player'),
        centerTitle: true,
        foregroundColor: Colors.lightBlue,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Column(
        children: [
          MusicCat(),
          MusicList(),
        ],
      ),
    );
  }
}
