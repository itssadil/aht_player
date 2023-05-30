import 'package:ahtplayer/providers/isLoopingProvider.dart';
import 'package:ahtplayer/providers/isSuffleProvider.dart';
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
    return Consumer<PlayPause>(
      builder: (context, playPauseIcon, child) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<IsSongLooping>(
              builder: (context, isLooping, child) {
                widget.audioPlayer.setLoopMode(
                    isLooping.isLooping ? LoopMode.one : LoopMode.all);
                return Expanded(
                  child: IconButton(
                    icon: Icon(
                      isLooping.isLooping ? Icons.repeat_one : Icons.repeat,
                      color: isLooping.isLooping
                          ? Colors.white
                          : Colors.lightBlueAccent,
                    ),
                    onPressed: () {
                      isLooping.changeSongLooping();
                    },
                  ),
                );
              },
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.skip_previous,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  widget.audioPlayer.seekToPrevious();
                  if (playPauseIcon.playPauseIcon == Icons.play_circle) {
                    playPauseIcon.changePlayPauseIcon();
                    widget.audioPlayer.play();
                  }
                },
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 70,
                child: IconButton(
                  icon: Icon(
                    playPauseIcon.playPauseIcon,
                    size: 60,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    if (playPauseIcon.playPauseIcon != Icons.play_circle) {
                      widget.audioPlayer.stop();
                    } else {
                      widget.audioPlayer.play();
                    }
                    playPauseIcon.changePlayPauseIcon();
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
                onPressed: () {
                  widget.audioPlayer.seekToNext();
                  if (playPauseIcon.playPauseIcon == Icons.play_circle) {
                    playPauseIcon.changePlayPauseIcon();
                    widget.audioPlayer.play();
                  }
                },
              ),
            ),
            Consumer<IsSongShuffle>(
              builder: (context, isShuffle, child) {
                widget.audioPlayer.setShuffleModeEnabled(isShuffle.isShuffle);
                return Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.shuffle,
                      color: isShuffle.isShuffle
                          ? Colors.white
                          : Colors.lightBlueAccent,
                    ),
                    onPressed: () {
                      isShuffle.changeSongSuffle();
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
