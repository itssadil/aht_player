import 'package:flutter/material.dart';

Widget songTitle(
    {required Size size, required String songTitle, required String subTitle}) {
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
              songTitle,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subTitle,
              style: TextStyle(
                  color: Colors.lightBlueAccent,
                  // fontSize: 20,
                  fontWeight: FontWeight.bold),
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
