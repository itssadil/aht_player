import 'package:ahtplayer/providers/durPosProvider.dart';
import 'package:ahtplayer/providers/volumeSetProvider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

Widget musicTimer({
  required Size size,
  required AudioPlayer audioPlayer,
}) {
  return Consumer<DurPosProvider>(
    builder: (context, durPos, child) {
      return Column(
        children: [
          Slider(
            min: Duration(microseconds: 0).inSeconds.toDouble(),
            value: durPos.position.inSeconds.toDouble(),
            max: durPos.duration.inSeconds.toDouble(),
            onChanged: (value) {
              changeSlider(value.toInt(), audioPlayer);
              value = value;
            },
            activeColor: Colors.lightBlueAccent,
            inactiveColor: Colors.blue.withOpacity(0.8),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    audioPlayer.seek(
                      Duration(seconds: durPos.position.inSeconds - 5),
                    );
                  },
                  child: Icon(Icons.replay_5, color: Colors.white),
                ),
                Text(
                  "${durPos.position.toString().split(".")[0]}",
                  style: TextStyle(color: Colors.white70),
                ),
                Consumer<VolumeSet>(
                  builder: (context, isVolUp, child) {
                    return GestureDetector(
                      onTap: () {
                        isVolUp.changeVolIcon();
                        audioPlayer.setVolume(isVolUp.isVolUp ? 0.5 : 0.0);
                      },
                      child: Icon(isVolUp.volIcon, color: isVolUp.icnColor),
                    );
                  },
                ),
                Text(
                  "${durPos.duration.toString().split(".")[0]}",
                  style: TextStyle(color: Colors.white70),
                ),
                GestureDetector(
                  onTap: () {
                    audioPlayer.seek(
                      Duration(seconds: durPos.position.inSeconds + 5),
                    );
                  },
                  child: Icon(Icons.forward_5, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

void changeSlider(int seconds, AudioPlayer audioPlayer) {
  Duration duration = Duration(seconds: seconds);
  audioPlayer.seek(duration);
}
