import 'package:flutter/material.dart';

class FooterPlayingProvider with ChangeNotifier {
  int _defaultIndex = 0;
  int get defaultIndex => _defaultIndex;
  changePlayingIndex(playingIndex) {
    _defaultIndex = playingIndex;
    notifyListeners();
  }
}
