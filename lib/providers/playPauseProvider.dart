import 'package:flutter/material.dart';

class PlayPause with ChangeNotifier {
  IconData _playPauseIcon = Icons.play_circle;
  IconData get playPauseIcon => _playPauseIcon;

  bool _isPlay = true;
  bool get isPlay => _isPlay;
  changePlayPauseIcon() {
    _isPlay = !_isPlay;
    if (_playPauseIcon == Icons.pause_circle)
      _playPauseIcon = Icons.play_circle;
    else
      _playPauseIcon = Icons.pause_circle;
    notifyListeners();
  }
}
