import 'package:ahtplayer/providers/allSongsListProvider.dart';
import 'package:ahtplayer/providers/favoriteProvider.dart';
import 'package:ahtplayer/providers/visiblePlaylistSongsProvider.dart';
import 'package:ahtplayer/widgets/allSongs.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class PlaylistSongs extends StatefulWidget {
  final AudioPlayer audioPlayer;
  var playlists;
  String playName;

  PlaylistSongs(
    this.audioPlayer,
    this.playlists,
    this.playName,
  );

  @override
  State<PlaylistSongs> createState() => _PlaylistSongsState();
}

class _PlaylistSongsState extends State<PlaylistSongs> {
  final OnAudioQuery _audioQuery = new OnAudioQuery();

  Color clr = Colors.tealAccent;
  double elvtion = 2;
  Color txtClr = Colors.black;
  bool isBtmSheet = false;
  bool isFromPlaylist = false;

  late int count;
  List<SongModel> playListSongs = [];
  List playListSongData = [];

  @override
  void initState() {
    super.initState();
    songCount();
    playListSongsList();
  }

  Future<void> playListSongsList() async {
    playListSongs = await _audioQuery.queryAudiosFrom(
        AudiosFromType.PLAYLIST, widget.playlists);
  }

  songCount() async {
    List<SongModel> songs = await _audioQuery.querySongs();

    if (songs != null) {
      count = songs.length;
      print("Total Songs: $count");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Consumer<VisiblePlaylistSongs>(
            builder: (context, isVisible, child) {
              return Visibility(
                visible:
                    widget.playName == "Favj~{UB;q4{['#j[S7'g" ? false : true,
                child: Card(
                  color: Colors.black,
                  child: ListTile(
                    textColor: Colors.white,
                    iconColor: Colors.white,
                    leading: IconButton(
                      onPressed: () {
                        isVisible.changeVisibleOption(0, "");
                      },
                      icon: Icon(Icons.keyboard_backspace),
                    ),
                    title: Text(
                      widget.playName == "j~{UB;q4{['#j[S7'g"
                          ? "Favorite"
                          : widget.playName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ),
          Consumer<FavoriteProvider>(
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
                          print(widget.playlists);
                          playListSongData.clear();
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.only(bottom: 100),
                            itemCount: items.data!.length,
                            itemBuilder: (context, index) {
                              if (playListSongData.length !=
                                  playListSongs.length) {
                                playListSongData
                                    .add(playListSongs[index].title);

                                items.data!.forEach((element) {
                                  if (element.title
                                      .contains(playListSongs[index].title)) {
                                    songsList.changeSongsListPlaylist(element);
                                  }
                                });
                                if ((playListSongData.contains(
                                    songsList.allSongs[index].title))) {
                                  print(
                                      "${playListSongs[index].id} ${playListSongs[index].title}");
                                  return AllSongs(
                                    clr,
                                    elvtion,
                                    txtClr,
                                    index,
                                    false,
                                    true,
                                    widget.playlists,
                                    playListSongs[index].id,
                                    isBtmSheet,
                                    songsList.allSongs,
                                    widget.audioPlayer,
                                  );
                                }
                              }

                              return Container();
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
        ],
      ),
    );
  }
}
