import 'package:ahtplayer/pages/musicPlayerUi/musicPlayerUi.dart';
import 'package:ahtplayer/providers/favoriteProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllSongs extends StatelessWidget {
  Color clr;
  double elvtion;
  Color txtClr;
  int index;
  bool isFav;

  AllSongs(this.clr, this.elvtion, this.txtClr, this.index, this.isFav);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elvtion,
      color: clr,
      child: ListTile(
        leading: Container(
          height: 60,
          width: 65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(
                  "https://img.freepik.com/free-vector/app-development-banner_33099-1720.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          "Song Title Song Title $index",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: txtClr),
        ),
        subtitle: Text(
          "Song Title Song TitleSong Title $index",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: txtClr),
        ),
        trailing: Consumer<FavoriteProvider>(
          builder: (context, favIndex, child) {
            return PopupMenuButton(
              icon: Icon(Icons.more_vert, color: Colors.teal),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Share"),
                      Icon(Icons.share),
                    ],
                  ),
                ),
                isFav
                    ? PopupMenuItem(
                        onTap: () => favIndex.addFav(index),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Favorite"),
                            Icon(Icons.favorite),
                          ],
                        ),
                      )
                    : PopupMenuItem(
                        onTap: () => favIndex.removeFav(index),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Unfavorite"),
                            Icon(Icons.heart_broken),
                          ],
                        ),
                      ),
                PopupMenuItem(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Add to Playlist"),
                      Icon(Icons.add_box_rounded),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MusicPlayerUI(),
            ),
          );
        },
      ),
    );
  }
}
