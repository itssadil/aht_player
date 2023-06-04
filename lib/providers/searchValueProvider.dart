import 'package:flutter/material.dart';

class songValueList with ChangeNotifier {
  List _songInfo = [];
  List get songInfo => _songInfo;

  songInfoList(item) {
    _songInfo = item;
    notifyListeners();
  }
}
