import 'package:flutter/material.dart';

Widget songTitle({required Size size}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.8,
        ),
        child: Text(
          'Song Title',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_border_outlined,
              color: Colors.lightBlueAccent)),
    ],
  );
}
