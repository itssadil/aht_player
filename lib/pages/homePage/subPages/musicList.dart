import 'package:ahtplayer/pages/musicPlayerUi/musicPlayerUi.dart';
import 'package:flutter/material.dart';

class MusicList extends StatelessWidget {
  const MusicList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
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
              ),
              subtitle: Text(
                "Song Title Song TitleSong Title $index",
                overflow: TextOverflow.ellipsis,
              ),
              trailing: PopupMenuButton(
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
                  PopupMenuItem(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Favorite"),
                        Icon(Icons.favorite_border_outlined),
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
        },
      ),
    );
  }
}
