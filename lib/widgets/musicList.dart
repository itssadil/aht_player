import 'package:ahtplayer/providers/favoriteProvider.dart';
import 'package:ahtplayer/providers/homeProvider.dart';
import 'package:ahtplayer/widgets/allSongs.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MusicList extends StatelessWidget {
  Color clr;
  double elvtion;
  Color txtClr;
  bool isBtmSheet;

  MusicList(this.clr, this.elvtion, this.txtClr, this.isBtmSheet);

  final OnAudioQuery _audioQuery = new OnAudioQuery();

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
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          String songTitle =
                              items.data![index].displayNameWOExt;

                          String songArtist =
                              items.data![index].artist.toString();
                          if (songArtist == "<unknown>") {
                            songArtist = "Unknown Artist";
                          }
                          String songSubTitle =
                              "$songArtist / ${items.data![index].album}";

                          if (favValue.favList.contains(index)) {
                            return AllSongs(
                              clr,
                              elvtion,
                              txtClr,
                              index,
                              false,
                              isBtmSheet,
                              songTitle,
                              songSubTitle,
                            );
                          }
                          return Container();
                        },
                      );
                    default:
                      return ListView.builder(
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          String songTitle =
                              items.data![index].displayNameWOExt;

                          String songArtist =
                              items.data![index].artist.toString();
                          if (songArtist == "<unknown>") {
                            songArtist = "Unknown Artist";
                          }
                          String songSubTitle =
                              "$songArtist / ${items.data![index].album}";

                          return favValue.favList.contains(index)
                              ? AllSongs(
                                  clr,
                                  elvtion,
                                  txtClr,
                                  index,
                                  false,
                                  isBtmSheet,
                                  songTitle,
                                  songSubTitle,
                                )
                              : AllSongs(
                                  clr,
                                  elvtion,
                                  txtClr,
                                  index,
                                  true,
                                  isBtmSheet,
                                  songTitle,
                                  songSubTitle,
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
