import 'package:ahtplayer/pages/musicPlayerUi/musicPlayerUi.dart';
import 'package:ahtplayer/providers/allSongsListProvider.dart';
import 'package:ahtplayer/providers/footerPlayingProvider.dart';
import 'package:ahtplayer/providers/playPauseProvider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class FooterPlayingSection extends StatelessWidget {
  final AudioPlayer audioPlayer;

  FooterPlayingSection(this.audioPlayer);

  final OnAudioQuery _audioQuery = new OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Consumer<FooterPlayingProvider>(
      builder: (context, value, child) {
        int index = audioPlayer.currentIndex ?? 0;
        return FutureBuilder<List<SongModel>>(
          future: _audioQuery.querySongs(
            sortType: null,
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            ignoreCase: true,
          ),
          builder: (context, items) {
            var songModel = items.data?[index];
            return Positioned(
              bottom: 10,
              right: 10,
              left: 10,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Consumer<AllSongsList>(
                  builder: (context, songsList, child) {
                    return Consumer<PlayPause>(
                      builder: (context, playPause, child) {
                        return ListTile(
                          title: Text(
                            "${songModel?.title}",
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            "${songModel?.artist == "<unknown>" ? "Unknown Artist" : songModel?.artist} / ${songModel?.album}",
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              if (audioPlayer.currentIndex == null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MusicPlayerUI(
                                      songsList.allSongs,
                                      audioPlayer,
                                      index,
                                      Duration(seconds: 0),
                                      false,
                                    ),
                                  ),
                                );
                              }
                              if (playPause.playPauseIcon !=
                                  Icons.play_circle) {
                                audioPlayer.stop();
                              } else {
                                audioPlayer.play();
                              }
                              playPause.changePlayPauseIcon();
                              // print(audioPlayer.position);
                            },
                            child: Icon(
                              playPause.playPauseIcon,
                              size: 50,
                              color: Colors.blue,
                            ),
                          ),
                          onTap: () {
                            if (playPause.playPauseIcon == Icons.play_circle) {
                              playPause.changePlayPauseIcon();
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MusicPlayerUI(
                                  songsList.allSongs,
                                  audioPlayer,
                                  index,
                                  audioPlayer.position,
                                  audioPlayer.currentIndex != null
                                      ? true
                                      : false,
                                  // Duration(minutes: 1, seconds: 11),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
    // return Container();
  }
}
