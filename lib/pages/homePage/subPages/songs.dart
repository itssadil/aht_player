import 'package:ahtplayer/widgets/musicList.dart';
import 'package:flutter/material.dart';

class Songs extends StatelessWidget {
  const Songs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MusicList(Colors.tealAccent, 2, Colors.black, false);
  }
}
