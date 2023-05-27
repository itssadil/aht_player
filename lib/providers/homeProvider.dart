import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int _homeTab = 0;
  int get homeTab => _homeTab;
  changeHomeValue({required int homeValue}) {
    _homeTab = homeValue;
    notifyListeners();
  }
}
