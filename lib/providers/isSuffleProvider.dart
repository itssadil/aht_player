import 'package:flutter/material.dart';

class IsSongShuffle with ChangeNotifier {
  bool _isShuffle = false;
  bool get isShuffle => _isShuffle;

  changeSongSuffle() {
    _isShuffle = !_isShuffle;
    notifyListeners();
  }
}
