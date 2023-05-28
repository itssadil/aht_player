import 'package:ahtplayer/providers/homeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicCat extends StatelessWidget {
  const MusicCat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        categories(
          size: size,
          homeTab: 0,
          clr: Colors.cyan,
          clr2: Colors.cyanAccent,
          icn: Icon(Icons.list_alt, color: Colors.white),
          txt: "All Songs",
        ),
        categories(
          size: size,
          homeTab: 1,
          clr: Colors.pink,
          clr2: Colors.pinkAccent,
          icn: Icon(Icons.favorite, color: Colors.white),
          txt: "Favorite",
        ),
        categories(
          size: size,
          homeTab: 2,
          clr: Colors.purple,
          clr2: Colors.purpleAccent,
          icn: Icon(Icons.playlist_add_check_circle_sharp, color: Colors.white),
          txt: "Playlist",
        ),
      ],
    );
  }

  categories({
    required Size size,
    required int homeTab,
    required Color clr,
    required Color clr2,
    required Icon icn,
    required String txt,
  }) {
    int homeValue = homeTab;
    return Consumer<HomeProvider>(
      builder: (context, homeTab, child) {
        return GestureDetector(
          onTap: () => homeTab.changeHomeValue(homeValue: homeValue),
          child: Container(
            height: size.width * 0.25,
            width: size.width * 0.25,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  clr2,
                  clr,
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icn,
                  SizedBox(height: 5),
                  Text(
                    txt,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
