import 'package:ahtplayer/providers/allSongsListProvider.dart';
import 'package:ahtplayer/providers/favoriteProvider.dart';
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
  bool isFromPlaylist;
  final AudioPlayer audioPlayer;
  var playlists;

  MusicList(
    this.clr,
    this.elvtion,
    this.txtClr,
    this.isBtmSheet,
    this.isFromPlaylist,
    this.audioPlayer,
    this.playlists,
  );

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  final OnAudioQuery _audioQuery = new OnAudioQuery();

  late int count;
  List<SongModel> playListSongs = [];

  @override
  void initState() {
    super.initState();
    songCount();
    if (widget.isFromPlaylist) {
      playListSongsList();
    }
  }

  Future<void> playListSongsList() async {
    playListSongs = await _audioQuery.queryAudiosFrom(
        AudiosFromType.PLAYLIST, widget.playlists.id);
    print(
        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa${playListSongs[0].title}");
  }

  songCount() async {
    List<SongModel> songs = await _audioQuery.querySongs();

    if (songs != null) {
      count = songs.length;
      print("Total Songs: $count");
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
              var item = items.data;
              if (item != null) {
                if (items.hasData) {
                  return Consumer<AllSongsList>(
                    builder: (context, songsList, child) {
                      songsList.allSongs.clear();
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
                                  false,
                                  0,
                                  0,
                                  widget.isBtmSheet,
                                  songsList.allSongs,
                                  widget.audioPlayer,
                                )
                              : AllSongs(
                                  widget.clr,
                                  widget.elvtion,
                                  widget.txtClr,
                                  index,
                                  true,
                                  false,
                                  0,
                                  0,
                                  widget.isBtmSheet,
                                  songsList.allSongs,
                                  widget.audioPlayer,
                                );
                        },
                      );
                    },
                  );
                }
                if (item.isEmpty) {
                  return Center(
                    child: Text(
                      "No Songs Found",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
