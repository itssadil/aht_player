import 'package:flutter/material.dart';

class MusicPlayerTitle with ChangeNotifier {
  String _appTitle = "AHT Player";
  String get appTitle => _appTitle;
  changeTimerWatch(watchValue) {
    _appTitle = watchValue;
    notifyListeners();
  }
}
