import 'package:ahtplayer/pages/musicPlayerUi/musicPlayerUi.dart';
import 'package:ahtplayer/providers/favoriteProvider.dart';
import 'package:ahtplayer/providers/playPauseProvider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class AllSongs extends StatelessWidget {
  Color clr;
  double elvtion;
  Color txtClr;
  int index;
  bool isFav;
  bool isPlay;
  int playId;
  int playSongId;
  bool isBtmSheet;
  var songModel;
  final AudioPlayer audioPlayer;

  AllSongs(
    this.clr,
    this.elvtion,
    this.txtClr,
    this.index,
    this.isFav,
    this.isPlay,
    this.playId,
    this.playSongId,
    this.isBtmSheet,
    this.songModel,
    this.audioPlayer,
  );

  var myFooterPlayingProvider;

  final OnAudioQuery audioQuery = OnAudioQuery();
  String? playlistName;

  addPlaylistDialog(context, songModel) async {
    final updatedPlaylists = await audioQuery.queryPlaylists();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Playlist Name"),
                      suffixIcon: ElevatedButton(
                        onPressed: () {},
                        child: Icon(Icons.add),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      playlistName = value;
                    },
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: updatedPlaylists.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      child: ListTile(
                        leading: Icon(Icons.queue_music),
                        title: Text(updatedPlaylists[index].playlist),
                        trailing: Icon(Icons.add_box),
                        onTap: () => addSongToPlaylist(
                          songModel,
                          updatedPlaylists[index],
                          context,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> addSongToPlaylist(
      SongModel song, PlaylistModel playlist, context) async {
    await audioQuery.addToPlaylist(playlist.id, song.id);

    Navigator.pop(context);
  }

  List<PlaylistModel> playlists = [];

  bool favId = false;
  int favIndex = 0;

  Future<void> showFavList(BuildContext context, SongModel song) async {
    final updatedPlaylists = await audioQuery.queryPlaylists();
    playlists = updatedPlaylists;

    playlists.forEach((element) {
      if (element.playlist == "j~{UB;q4{['#j[S7'g") {
        favIndex = element.id;
        favId = true;
      }
    });
    if (favId) {
      await audioQuery.addToPlaylist(favIndex, song.id);
    } else {
      checkFav(context, song);
    }
  }

  checkFav(BuildContext context, SongModel song) async {
    await audioQuery.createPlaylist("j~{UB;q4{['#j[S7'g");
    showFavList(context, song);
  }

  Future<void> removeFromPlaylist(context, song) async {
    await audioQuery.removeFromPlaylist(playId, playSongId);
    print(playSongId);
    print(playId);
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    String songArtist = songModel[index].artist.toString();
    if (songArtist == "<unknown>") {
      songArtist = "Unknown Artist";
    }
    return Card(
      elevation: elvtion,
      color: clr,
      child: Consumer<PlayPause>(
        builder: (context, playPause, child) {
          return ListTile(
            leading: QueryArtworkWidget(
              id: songModel[index].id,
              type: ArtworkType.AUDIO,
              artworkBorder: BorderRadius.circular(10),
              artworkHeight: 45,
              artworkWidth: 50,
              nullArtworkWidget: Icon(
                Icons.image,
                size: 45,
                color: Colors.teal.withOpacity(0.7),
              ),
            ),
            title: Text(
              "${songModel[index].displayNameWOExt}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: txtClr),
            ),
            subtitle: Text(
              "$songArtist / ${songModel[index].album}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: txtClr.withOpacity(0.5)),
            ),
            trailing: Consumer<FavoriteProvider>(
              builder: (context, favIndex, child) {
                return isPlay
                    ? PopupMenuButton(
                        icon: Icon(Icons.more_vert, color: Colors.teal),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {
                              removeFromPlaylist(context, songModel[index].id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Remove"),
                                Icon(Icons.cancel_outlined),
                              ],
                            ),
                          ),
                        ],
                      )
                    : PopupMenuButton(
                        icon: Icon(Icons.more_vert, color: Colors.teal),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Share"),
                                Icon(Icons.share),
                              ],
                            ),
                          ),
                          isFav
                              ? PopupMenuItem(
                                  // onTap: () => favIndex.addFav(index),
                                  onTap: () {
                                    showFavList(context, songModel[index]);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Favorite"),
                                      Icon(Icons.favorite),
                                    ],
                                  ),
                                )
                              : PopupMenuItem(
                                  onTap: () => favIndex.removeFav(index),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Unfavorite"),
                                      Icon(Icons.heart_broken),
                                    ],
                                  ),
                                ),
                          PopupMenuItem(
                            onTap: () =>
                                addPlaylistDialog(context, songModel[index]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Add to Playlist"),
                                Icon(Icons.add_box_rounded),
                              ],
                            ),
                          ),
                        ],
                      );
              },
            ),
            onTap: () {
              if (playPause.playPauseIcon == Icons.play_circle) {
                playPause.changePlayPauseIcon();
              }

              if (isBtmSheet == true) {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MusicPlayerUI(
                      songModel,
                      audioPlayer,
                      index,
                      Duration(seconds: 0),
                      false,
                    ),
                  ),
                );
              } else {
                print("aaaaaaaaaaaaaaaaaaaaaaa ${songModel[index].id}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MusicPlayerUI(
                      songModel,
                      audioPlayer,
                      index,
                      Duration(seconds: 0),
                      false,
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
