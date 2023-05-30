import 'package:ahtplayer/providers/favoriteProvider.dart';
import 'package:ahtplayer/providers/homeProvider.dart';
import 'package:ahtplayer/widgets/allSongs.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MusicList extends StatelessWidget {
  Color clr;
  double elvtion;
  Color txtClr;
  bool isBtmSheet;
  final AudioPlayer audioPlayer;

  MusicList(
      this.clr, this.elvtion, this.txtClr, this.isBtmSheet, this.audioPlayer);

  final OnAudioQuery _audioQuery = new OnAudioQuery();
  List<SongModel> allSongs = [];

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
              return Consumer<HomeProvider>(
                builder: (context, value, child) {
                  switch (value.homeTab) {
                    case 1:
                      return ListView.builder(
                        itemCount: items.data!.length,
                        itemBuilder: (context, index) {
                          var songModel = items.data![index];
                          allSongs.addAll(items.data!);

                          if (favValue.favList.contains(index)) {
                            return AllSongs(
                              clr,
                              elvtion,
                              txtClr,
                              index,
                              false,
                              isBtmSheet,
                              // songModel,
                              allSongs,
                              audioPlayer,
                              index,
                            );
                          }
                          return Container();
                        },
                      );
                    default:
                      return ListView.builder(
                        itemCount: items.data!.length,
                        itemBuilder: (context, index) {
                          var songModel = items.data![index];

                          allSongs.addAll(items.data!);
                          return favValue.favList.contains(index)
                              ? AllSongs(
                                  clr,
                                  elvtion,
                                  txtClr,
                                  index,
                                  false,
                                  isBtmSheet,
                                  // songModel,
                                  allSongs,
                                  audioPlayer,
                                  index,
                                )
                              : AllSongs(
                                  clr,
                                  elvtion,
                                  txtClr,
                                  index,
                                  true,
                                  isBtmSheet,
                                  // songModel,
                                  allSongs,
                                  audioPlayer,
                                  index,
                                );
                        },
                      );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
