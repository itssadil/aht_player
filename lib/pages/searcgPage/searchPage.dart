import 'package:ahtplayer/pages/musicPlayerUi/musicPlayerUi.dart';
import 'package:ahtplayer/providers/allSongsListProvider.dart';
import 'package:ahtplayer/providers/searchValueProvider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  AudioPlayer audioPlayer = AudioPlayer();

  SearchPage(this.audioPlayer);

  List<SongModel> searchSongsList = [];

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
      body: FutureBuilder(
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
                                itemCount: songValue.songInfo.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      leading: Icon(Icons.music_note),
                                      title: Text(
                                          songValue.songInfo[index]["title"]),
                                      subtitle: Text(
                                        "${songValue.songInfo[index]["_id"]}/${songValue.songInfo[index]["artist"] == "<unknown>" ? "Unknown Artist" : songValue.songInfo[index]["artist"]} / ${songValue.songInfo[index]["album"]}",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      onTap: () {
                                        searchSongsList.clear();
                                        // searchSongsList.add(songValue
                                        //     .songInfo[index] as SongModel);

                                        allSongs.allSongs.forEach((element) {
                                          if (element.id ==
                                              songValue.songInfo[index]
                                                  ["_id"]) {
                                            searchSongsList.add(element);
                                            searchSongsList
                                                .addAll(allSongs.allSongs);
                                          }
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MusicPlayerUI(
                                              searchSongsList,
                                              audioPlayer,
                                              index,
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
    );
  }
}
