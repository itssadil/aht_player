import 'package:ahtplayer/pages/providers/isSearchVisibleProvider.dart';
import 'package:ahtplayer/pages/widgets/musicList.dart';
import 'package:ahtplayer/pages/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'subPages/musicCat.dart';
import 'subPages/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // bool isSearchVisible = false;
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
          }),
        ],
      ),
      body: Column(
        children: [
          Consumer<IsSearchVisibleProvider>(
              builder: (context, isSearchVisible, child) {
            return Visibility(
                visible: !isSearchVisible.isSearchVisible, child: MusicCat());
          }),
          Consumer<IsSearchVisibleProvider>(
              builder: (context, isSearchVisible, child) {
            return Visibility(
                visible: isSearchVisible.isSearchVisible, child: Search());
          }),
          // Visibility(visible: isSearchVisible, child: Search()),
          MusicList(Colors.tealAccent, 2, Colors.black),
        ],
      ),
    );
  }
}
