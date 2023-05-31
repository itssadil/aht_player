import 'package:ahtplayer/widgets/musicList.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Songs extends StatelessWidget {
  final AudioPlayer audioPlayer;
  Songs(this.audioPlayer);
  @override
  Widget build(BuildContext context) {
    return MusicList(Colors.tealAccent, 2, Colors.black, false, audioPlayer);
  }
}
