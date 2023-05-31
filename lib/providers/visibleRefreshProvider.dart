import 'package:flutter/material.dart';

class VisibleRefreshProvider with ChangeNotifier {
  bool _isVisibleRefresh = false;
  bool get isVisibleRefresh => _isVisibleRefresh;
  changeVisibleRefresh() {
    _isVisibleRefresh = true;
    notifyListeners();
  }
}
