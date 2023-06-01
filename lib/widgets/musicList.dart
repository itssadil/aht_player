import 'package:ahtplayer/providers/allSongsListProvider.dart';
import 'package:ahtplayer/providers/favoriteProvider.dart';
import 'package:ahtplayer/providers/homeProvider.dart';
import 'package:ahtplayer/widgets/allSongs.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MusicList extends StatefulWidget {
  Color clr;
  double elvtion;
  Color txtClr;
  bool isBtmSheet;
  final AudioPlayer audioPlayer;

  MusicList(
      this.clr, this.elvtion, this.txtClr, this.isBtmSheet, this.audioPlayer);

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  final OnAudioQuery _audioQuery = new OnAudioQuery();

  late int count;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    songCount();
  }

  songCount() async {
    List<SongModel> songs = await _audioQuery.querySongs();

    if (songs != null) {
      count = songs.length;
      print(count); // Output: 10 (Example count)
    }
  }

  // List<SongModel> allSongs = [];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<FavoriteProvider>(
        builder: (context, favValue, child) {
          return FutureBuilder<List<SongModel>>(
            future: _audioQuery.querySongs(
              sortType: null,
              orderType: OrderType.ASC_OR_SMALLER,
              uriType: UriType.EXTERNAL,
              ignoreCase: true,
            ),
            builder: (context, items) {
              if (items.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (items.data!.isEmpty) {
                return Center(
                  child: Text(
                    "No Songs Found",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }
              return Consumer<AllSongsList>(
                builder: (context, songsList, child) {
                  return Consumer<HomeProvider>(
                    builder: (context, value, child) {
                      switch (value.homeTab) {
                        case 1:
                          return ListView.builder(
                            padding: EdgeInsets.only(bottom: 75),
                            itemCount: items.data!.length,
                            itemBuilder: (context, index) {
                              // var songModel = items.data![index];
                              // allSongs.addAll(items.data!);

                              if (songsList.allSongs.length != count) {
                                songsList.changeSongsList(items.data!);
                              }
                              if (favValue.favList.contains(index)) {
                                return AllSongs(
                                  widget.clr,
                                  widget.elvtion,
                                  widget.txtClr,
                                  index,
                                  false,
                                  widget.isBtmSheet,
                                  // songModel,
                                  songsList.allSongs,
                                  widget.audioPlayer,
                                );
                              }
                              return Container();
                            },
                          );
                        default:
                          return ListView.builder(
                            padding: EdgeInsets.only(bottom: 75),
                            itemCount: items.data!.length,
                            itemBuilder: (context, index) {
                              // var songModel = items.data![index];

                              if (songsList.allSongs.length != count) {
                                songsList.changeSongsList(items.data!);
                              }
                              return favValue.favList.contains(index)
                                  ? AllSongs(
                                      widget.clr,
                                      widget.elvtion,
                                      widget.txtClr,
                                      index,
                                      false,
                                      widget.isBtmSheet,
                                      // songModel,
                                      songsList.allSongs,
                                      widget.audioPlayer,
                                    )
                                  : AllSongs(
                                      widget.clr,
                                      widget.elvtion,
                                      widget.txtClr,
                                      index,
                                      true,
                                      widget.isBtmSheet,
                                      // songModel,
                                      songsList.allSongs,
                                      widget.audioPlayer,
                                    );
                            },
                          );
                      }
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
