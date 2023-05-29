import 'package:flutter/material.dart';

class DurPosProvider with ChangeNotifier {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  Duration get duration => _duration;
  Duration get position => _position;
  changeDurationValue(durationValue) {
    _duration = durationValue;
    notifyListeners();
  }

  changePositionValue(positionValue) {
    _position = positionValue;
    notifyListeners();
  }
}
