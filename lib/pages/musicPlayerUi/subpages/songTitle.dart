import 'package:flutter/material.dart';

Widget songTitle({required Size size, required var songModel}) {
  String songArtist = songModel.artist.toString();
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
              songModel.displayNameWOExt,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "$songArtist / ${songModel.album}",
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
