import 'package:ahtplayer/pages/playlistPage/subpages/playlistSongs.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

// class Favorite extends StatelessWidget {
//   final AudioPlayer audioPlayer;
//   Favorite(this.audioPlayer);
//
//   @override
//   Widget build(BuildContext context) {
//     return MusicList(
//         Colors.tealAccent, 2, Colors.black, false, false, audioPlayer, "");
//   }
// }

class Favorite extends StatelessWidget {
  final AudioPlayer audioPlayer;

  Favorite(this.audioPlayer);

  final OnAudioQuery audioQuery = OnAudioQuery();

  List<PlaylistModel> playlists = [];

  int favId = 0;

  Future<void> showPlayList() async {
    final updatedPlaylists = await audioQuery.queryPlaylists();
    playlists = updatedPlaylists;
    print(playlists);
    if (playlists.contains("ttf")) {
      print("aaaaaaaaaaaaaaaaaaaa");
    }
    playlists.forEach((element) {
      if (element.playlist == "j~{UB;q4{['#j[S7'g") {
        favId = element.id;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(playlists.length);
    return FutureBuilder(
      future: showPlayList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return PlaylistSongs(
            audioPlayer,
            favId,
            "Favj~{UB;q4{['#j[S7'g",
          );
        } else {
          return Center();
        }
      },
    );
  }
}
