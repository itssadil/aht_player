import 'package:ahtplayer/providers/playPauseProvider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class PlayIcons extends StatefulWidget {
  var songModel;
  final AudioPlayer audioPlayer;

  PlayIcons(this.songModel, this.audioPlayer);

  @override
  State<PlayIcons> createState() => _PlayIconsState(songModel);
}

class _PlayIconsState extends State<PlayIcons> {
  var songModel;

  _PlayIconsState(this.songModel);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: IconButton(
            icon: Icon(
              Icons.repeat,
              color: Colors.lightBlueAccent,
            ),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(
              Icons.skip_previous,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 70,
            child: Consumer<PlayPause>(
              builder: (context, playPauseIcon, child) {
                return IconButton(
                  icon: Icon(
                    playPauseIcon.playPauseIcon,
                    size: 60,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    if (playPauseIcon.playPauseIcon != Icons.play_circle) {
                      widget.audioPlayer.pause();
                    } else {
                      widget.audioPlayer.play();
                    }
                    playPauseIcon.changePlayPauseIcon();
                  },
                );
              },
            ),
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(
              Icons.skip_next,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: IconButton(
            icon: Icon(
              Icons.shuffle,
              color: Colors.lightBlueAccent,
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
