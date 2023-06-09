import 'package:ahtplayer/pages/musicPlayerUi/musicPlayerUi.dart';
import 'package:ahtplayer/providers/allSongsListProvider.dart';
import 'package:ahtplayer/providers/playPauseProvider.dart';
import 'package:ahtplayer/providers/searchValueProvider.dart';
import 'package:ahtplayer/widgets/footerPlaying.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  AudioPlayer audioPlayer = AudioPlayer();

  SearchPage(this.audioPlayer);

  List<SongModel> searchSongsList = [];
  int newSongIndex = 0;

  Future<void> getSongInfo(newV, context) async {
    OnAudioQuery onAudioQuery = OnAudioQuery();
    var songValueProvider = Provider.of<songValueList>(context, listen: false);
    songValueProvider.songInfoList(
        await onAudioQuery.queryWithFilters(newV, WithFiltersType.AUDIOS));

    // if (songs.isNotEmpty) {
    //     print(songInfo);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search...'),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: getSongInfo("", context),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? Consumer<songValueList>(
                      builder: (context, songValue, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Search song...",
                                ),
                                onChanged: (value) {
                                  getSongInfo(value, context);
                                },
                              ),
                            ),
                            Expanded(
                              child: Consumer<AllSongsList>(
                                builder: (context, allSongs, child) {
                                  return ListView.builder(
                                    keyboardDismissBehavior:
                                        ScrollViewKeyboardDismissBehavior
                                            .onDrag,
                                    itemCount: songValue.songInfo.length,
                                    itemBuilder: (context, index) {
                                      return Consumer<PlayPause>(
                                        builder: (context, playPause, child) {
                                          return Card(
                                            child: ListTile(
                                              leading: Icon(Icons.music_note),
                                              title: Text(songValue
                                                  .songInfo[index]["title"]),
                                              subtitle: Text(
                                                "${songValue.songInfo[index]["_id"]}/${songValue.songInfo[index]["artist"] == "<unknown>" ? "Unknown Artist" : songValue.songInfo[index]["artist"]} / ${songValue.songInfo[index]["album"]}",
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              onTap: () {
                                                searchSongsList.clear();

                                                allSongs.allSongs
                                                    .forEach((element) {
                                                  if (element.title ==
                                                      songValue.songInfo[index]
                                                          ["title"]) {
                                                    newSongIndex = allSongs
                                                        .allSongs
                                                        .indexOf(element);
                                                  }
                                                });

                                                if (playPause.playPauseIcon ==
                                                    Icons.play_circle) {
                                                  playPause
                                                      .changePlayPauseIcon();
                                                }

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MusicPlayerUI(
                                                      allSongs.allSongs,
                                                      audioPlayer,
                                                      newSongIndex,
                                                      Duration(seconds: 0),
                                                      false,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
          FooterPlayingSection(audioPlayer),
        ],
      ),
    );
  }
}
