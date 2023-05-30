import 'package:ahtplayer/widgets/musicList.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class footerSongs extends StatelessWidget {
  final AudioPlayer audioPlayer;
  footerSongs(this.audioPlayer);
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
        return MusicList(Color(0xff001BF6).withOpacity(0.5), 0, Colors.white,
            true, audioPlayer);
      },
    );
  }
}
