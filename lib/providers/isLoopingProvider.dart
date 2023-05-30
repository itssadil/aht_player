import 'package:flutter/material.dart';

class IsSongLooping with ChangeNotifier {
  bool _isLooping = false;
  bool get isLooping => _isLooping;

  changeSongLooping() {
    _isLooping = !_isLooping;
    notifyListeners();
  }
}
