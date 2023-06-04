import 'package:flutter/material.dart';

class VisiblePlaylistSongs with ChangeNotifier {
  bool _isVisible = false;
  bool get isVisible => _isVisible;
  int _playListId = 0;
  int get playListId => _playListId;
  String _playListName = "";
  String get playListName => _playListName;
  changeVisibleOption(playId, playName) {
    _playListName = playName;
    _playListId = playId;
    _isVisible = !_isVisible;
    notifyListeners();
  }
}
