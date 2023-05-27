import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  List _favList = [];
  List get favList => _favList;
  addFav(favIndex) {
    _favList.add(favIndex);
    notifyListeners();
  }

  removeFav(favIndex) {
    _favList.remove(favIndex);
    notifyListeners();
  }
}
