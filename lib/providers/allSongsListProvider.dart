import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllSongsList with ChangeNotifier {
  List<SongModel> _allSongs = [];
  List<SongModel> get allSongs => _allSongs;
  changeSongsList(items) {
    _allSongs.addAll(items);
    notifyListeners();
  }
}
