import 'package:flutter/material.dart';

Widget songTitle({
  required Size size,
  required List songModel,
  required int songIndex,
}) {
  String songArtist = songModel[songIndex].artist.toString();
  if (songArtist == "<unknown>") {
    songArtist = "Unknown Artist";
  }
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.7,
        ),
        child: Column(
          children: [
            Text(
              songModel[songIndex].displayNameWOExt,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "$songArtist / ${songModel[songIndex].album}",
              style: TextStyle(
                  color: Colors.lightBlueAccent, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_border_outlined,
              color: Colors.lightBlueAccent)),
    ],
  );
}
