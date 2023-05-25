import 'package:flutter/material.dart';

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
          clr: Colors.pink,
          clr2: Colors.pinkAccent,
          icn: Icon(Icons.favorite, color: Colors.white),
          txt: "Favorite",
        ),
        categories(
          size: size,
          clr: Colors.purple,
          clr2: Colors.purpleAccent,
          icn: Icon(Icons.playlist_add_check_circle_sharp, color: Colors.white),
          txt: "Playlist",
        ),
        categories(
          size: size,
          clr: Colors.cyan,
          clr2: Colors.cyanAccent,
          icn: Icon(Icons.watch_later_outlined, color: Colors.white),
          txt: "Recent",
        ),
      ],
    );
  }

  categories({
    required Size size,
    required Color clr,
    required Color clr2,
    required Icon icn,
    required String txt,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: size.width * 0.25,
        width: size.width * 0.25,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          // color: clr,
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
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
