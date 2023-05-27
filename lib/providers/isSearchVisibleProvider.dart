import 'package:flutter/material.dart';

class IsSearchVisibleProvider with ChangeNotifier {
  bool _isSearchVisible = false;
  bool get isSearchVisible => _isSearchVisible;
  changeSearchVisible() {
    _isSearchVisible = !_isSearchVisible;
    notifyListeners();
  }
}
