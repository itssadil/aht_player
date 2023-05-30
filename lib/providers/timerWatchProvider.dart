import 'package:flutter/material.dart';

class TimerWatch with ChangeNotifier {
  String _appTitle = "AHT Player";
  String get appTitle => _appTitle;
  changeTimerWatch(watchValue) {
    _appTitle = watchValue;
    notifyListeners();
  }
}
