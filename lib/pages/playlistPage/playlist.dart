import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Playlist extends StatefulWidget {
  Playlist({Key? key}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  List<PlaylistModel> playlists = [];

  late String playlistName;

  @override
  void initState() {
    super.initState();
    showPlayList();
  }

/*============================================================
                      CREATE PLAYLIST
============================================================*/
  createPlaylistSheet() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10,
              bottom: 10,
              top: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Playlist Name"),
                  ),
                  onChanged: (value) {
                    playlistName = value;
                  },
                ),
                // Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Close"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        createPlaylist();
                        Navigator.pop(context);
                      },
                      child: Text("Add"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> createPlaylist() async {
    // final songs = await audioQuery.querySongs();

    await audioQuery.createPlaylist(
      playlistName,
    );
    showPlayList();
  }

/*============================================================
                      REMOVE PLAYLIST
============================================================*/

  Future<void> removePlaylist(PlaylistModel playlist) async {
    await audioQuery.removePlaylist(playlist.id);
    showPlayList();
  }

/*============================================================
                      SHOW PLAYLIST
============================================================*/

  Future<void> showPlayList() async {
    // final songs = await audioQuery.querySongs();

    final updatedPlaylists = await audioQuery.queryPlaylists();
    setState(() {
      playlists = updatedPlaylists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 20),
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              final playlist = playlists[index];
              return ListTile(
                leading: Icon(Icons.queue_music),
                title: Text(playlist.playlist),
                trailing: PopupMenuButton(
                  icon: Icon(Icons.more_vert, color: Colors.teal),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        removePlaylist(playlist);
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
                ),
                onTap: () {
                  // Handle playlist selection
                },
              );
            },
          ),
        ),
        Positioned(
          bottom: 40,
          right: 10,
          child: ElevatedButton(
            onPressed: () {
              createPlaylistSheet();
            },
            child: Icon(
              Icons.add,
              size: 30,
            ),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(10),
              backgroundColor: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}
