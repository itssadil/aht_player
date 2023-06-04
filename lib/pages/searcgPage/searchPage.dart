import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SongModel? songInfo;
  String songId =
      "audio"; // Replace with the actual song ID you want to retrieve information for

  @override
  void initState() {
    super.initState();
    getSongInfo();
  }

  Future<void> getSongInfo() async {
    OnAudioQuery onAudioQuery = OnAudioQuery();
    List songs =
        await onAudioQuery.queryWithFilters(songId, WithFiltersType.AUDIOS);
    print(songs[1]["_id"]);

    if (songs.isNotEmpty) {
      setState(() {
        songInfo = songs as SongModel?;
        print(songInfo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Song Information'),
      ),
      body: songInfo != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.music_note),
                  title: Text(songInfo!.title),
                  subtitle: Text(songInfo!.artist.toString()),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Album: ${songInfo!.album}'),
                      Text('Duration: ${songInfo!.duration}'),
                      Text('File Path: ${songInfo!.data}'),
                      // Add more song information fields as needed
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
