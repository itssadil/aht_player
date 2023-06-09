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

  @override
  Widget build(BuildContext context) {
    return Consumer<FooterPlayingProvider>(
      builder: (context, value, child) {
        int songIndex = value.defaultIndex;
        return FooterBodySection(songIndex, audioPlayer);
      },
    );
    // return Container();
  }
}

class FooterBodySection extends StatefulWidget {
  int songIndex;
  final AudioPlayer audioPlayer;

  FooterBodySection(this.songIndex, this.audioPlayer);

  @override
  State<FooterBodySection> createState() => _FooterBodySectionState();
}

class _FooterBodySectionState extends State<FooterBodySection> {
  final OnAudioQuery _audioQuery = new OnAudioQuery();

  @override
  void initState() {
    super.initState();

    listenToSongIndex();
  }

  void listenToSongIndex() {
    widget.audioPlayer.currentIndexStream.listen((event) {
      setState(() {
        if (event != null) {
          widget.songIndex = event;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      ),
      builder: (context, items) {
        return items.connectionState == ConnectionState.done
            ? Positioned(
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
                              "${songsList.allSongs[widget.songIndex].title}",
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              "${songsList.allSongs[widget.songIndex].artist == "<unknown>" ? "Unknown Artist" : songsList.allSongs[widget.songIndex].artist} / ${songsList.allSongs[widget.songIndex].album}",
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                if (widget.audioPlayer.currentIndex == null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MusicPlayerUI(
                                        songsList.allSongs,
                                        widget.audioPlayer,
                                        widget.songIndex,
                                        Duration(seconds: 0),
                                        false,
                                      ),
                                    ),
                                  );
                                }
                                if (playPause.playPauseIcon !=
                                    Icons.play_circle) {
                                  widget.audioPlayer.stop();
                                } else {
                                  widget.audioPlayer.play();
                                }
                                playPause.changePlayPauseIcon();
                              },
                              child: Icon(
                                playPause.playPauseIcon,
                                size: 50,
                                color: Colors.blue,
                              ),
                            ),
                            onTap: () {
                              if (playPause.playPauseIcon ==
                                  Icons.play_circle) {
                                playPause.changePlayPauseIcon();
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MusicPlayerUI(
                                    songsList.allSongs,
                                    widget.audioPlayer,
                                    widget.songIndex,
                                    widget.audioPlayer.position,
                                    widget.audioPlayer.currentIndex != null
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
              )
            : SizedBox();
      },
    );
  }
}
