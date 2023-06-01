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
  bool isBtmSheet;
  var songModel;
  final AudioPlayer audioPlayer;

  AllSongs(
    this.clr,
    this.elvtion,
    this.txtClr,
    this.index,
    this.isFav,
    this.isBtmSheet,
    this.songModel,
    this.audioPlayer,
  );

  var myFooterPlayingProvider;

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
                return PopupMenuButton(
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
                            onTap: () => favIndex.addFav(index),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Favorite"),
                                Icon(Icons.favorite),
                              ],
                            ),
                          )
                        : PopupMenuItem(
                            onTap: () => favIndex.removeFav(index),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Unfavorite"),
                                Icon(Icons.heart_broken),
                              ],
                            ),
                          ),
                    PopupMenuItem(
                      onTap: () {
                        // stopPlay(songUri);
                      },
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
