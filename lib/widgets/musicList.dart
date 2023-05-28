import 'package:ahtplayer/providers/favoriteProvider.dart';
import 'package:ahtplayer/providers/homeProvider.dart';
import 'package:ahtplayer/widgets/allSongs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicList extends StatelessWidget {
  Color clr;
  double elvtion;
  Color txtClr;
  bool isBtmSheet;

  MusicList(this.clr, this.elvtion, this.txtClr, this.isBtmSheet);

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
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      // for (index; index < 20; index++)
                      if (favValue.favList.contains(index))
                        return AllSongs(
                            clr, elvtion, txtClr, index, false, isBtmSheet);
                      return Container();
                    },
                  );
                default:
                  return ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return favValue.favList.contains(index)
                          ? AllSongs(
                              clr, elvtion, txtClr, index, false, isBtmSheet)
                          : AllSongs(
                              clr, elvtion, txtClr, index, true, isBtmSheet);
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
