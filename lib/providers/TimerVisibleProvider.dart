import 'package:flutter/material.dart';

class TimerVisible with ChangeNotifier {
  bool _isTimerVisible = true;
  bool get isTimerVisible => _isTimerVisible;
  changeHomeValue() {
    _isTimerVisible = !_isTimerVisible;
    notifyListeners();
  }
}
