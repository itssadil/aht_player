import 'package:ahtplayer/providers/favoriteProvider.dart';
import 'package:ahtplayer/providers/homeProvider.dart';
import 'package:ahtplayer/widgets/allSongs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicList extends StatelessWidget {
  Color clr;
  double elvtion;
  Color txtClr;

  MusicList(this.clr, this.elvtion, this.txtClr);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<FavoriteProvider>(
        builder: (context, favValue, child) {
          return Consumer<HomeProvider>(
            builder: (context, value, child) {
              switch (value.homeTab) {
                case 1:
                  return ListView.builder(
                    itemCount: favValue.favList.length,
                    itemBuilder: (context, index) {
                      // if (favValue.favList[index] != index)
                      //   return AllSongs(clr, elvtion, txtClr, index, true);
                      for (index; index < 20; index++)
                        if (favValue.favList.contains("$index") != "$index")
                          return AllSongs(clr, elvtion, txtClr, index, true);
                    },
                  );
                default:
                  return ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return AllSongs(clr, elvtion, txtClr, index, false);
                    },
                  );
              }
            },
          );
        },
      ),
    );
  }
}
