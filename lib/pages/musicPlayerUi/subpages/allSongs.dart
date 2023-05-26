import 'package:ahtplayer/pages/widgets/musicList.dart';
import 'package:flutter/material.dart';

class allSongs extends StatelessWidget {
  const allSongs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: Colors.white54),
        ListTile(
          title: Text(
            "All songs",
            style: TextStyle(color: Colors.white),
          ),
          leading:
              Icon(Icons.my_library_music_sharp, color: Colors.lightBlueAccent),
          trailing: Icon(
            Icons.keyboard_arrow_up_outlined,
            color: Colors.lightBlueAccent,
          ),
          onTap: () => _openModalSheet(context),
        ),
      ],
    );
  }

  _openModalSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Color(0xff001BF6).withOpacity(0.2),
      context: context,
      builder: (BuildContext context) {
        return MusicList(Color(0xff001BF6).withOpacity(0.5), 0, Colors.white);
      },
    );
  }
}
