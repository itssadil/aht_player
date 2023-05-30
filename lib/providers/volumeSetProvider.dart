import 'package:flutter/material.dart';

class VolumeSet with ChangeNotifier {
  IconData _volIcon = Icons.volume_up_sharp;
  IconData get volIcon => _volIcon;

  Color _icnColor = Colors.white;
  Color get icnColor => _icnColor;

  bool _isVolUp = true;
  bool get isVolUp => _isVolUp;
  changeVolIcon() {
    _isVolUp = !_isVolUp;
    if (_volIcon == Icons.volume_up_sharp) {
      _volIcon = Icons.volume_off_sharp;
      _icnColor = Colors.white70;
    } else {
      _volIcon = Icons.volume_up_sharp;
      _icnColor = Colors.white;
    }
    notifyListeners();
  }
}
