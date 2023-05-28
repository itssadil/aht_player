import 'package:ahtplayer/widgets/musicList.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Songs extends StatelessWidget {
  Songs({Key? key}) : super(key: key);
  final AudioPlayer _audioPlayer = new AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return MusicList(Colors.tealAccent, 2, Colors.black, false, _audioPlayer);
  }
}
