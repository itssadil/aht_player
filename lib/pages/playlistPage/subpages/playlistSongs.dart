import 'package:ahtplayer/pages/musicPlayerUi/musicPlayerUi.dart';
import 'package:ahtplayer/providers/playPauseProvider.dart';
import 'package:ahtplayer/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class PlaylistSongs extends StatelessWidget {
  final PlaylistModel playlist;
  final AudioPlayer audioPlayer;

  PlaylistSongs(this.playlist, this.audioPlayer);

  OnAudioQuery audioQuery = OnAudioQuery();

  Future<List<SongModel>> fetchPlaylistSongs(fatchList) async {
    return await audioQuery.queryAudiosFrom(
      AudiosFromType.PLAYLIST,
      fatchList.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title(appTitle: playlist.playlist),
      ),
      body: FutureBuilder<List<SongModel>>(
        future: fetchPlaylistSongs(playlist),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final songs = snapshot.data;

            return Consumer<PlayPause>(
              builder: (context, playPause, child) {
                return ListView.builder(
                  itemCount: songs!.length,
                  itemBuilder: (context, index) {
                    final song = songs[index];

                    String songArtist = song.artist.toString();
                    if (songArtist == "<unknown>") {
                      songArtist = "Unknown Artist";
                    }

                    // print(
                    //     "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ${song.id} ${song.data}");
                    return ListTile(
                      leading: QueryArtworkWidget(
                        id: song.id,
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
                        "${song.displayNameWOExt}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        "$songArtist / ${song.album}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black.withOpacity(0.5)),
                      ),
                      onTap: () {
                        if (playPause.playPauseIcon == Icons.play_circle) {
                          playPause.changePlayPauseIcon();
                        }
                        // audioPlayer.play();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MusicPlayerUI(
                              songs,
                              audioPlayer,
                              index,
                              Duration(seconds: 0),
                              false,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error fetching playlist songs');
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
