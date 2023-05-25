import 'package:flutter/material.dart';

Widget playIcons() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: IconButton(
          icon: Icon(
            Icons.repeat,
            color: Colors.lightBlueAccent,
          ),
          onPressed: () {},
        ),
      ),
      Expanded(
        child: IconButton(
          icon: Icon(
            Icons.skip_previous,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      Expanded(
        child: SizedBox(
          height: 70,
          child: IconButton(
            icon: Icon(
              Icons.play_circle,
              size: 60,
              color: Colors.white70,
            ),
            onPressed: () {},
          ),
        ),
      ),
      Expanded(
        child: IconButton(
          icon: Icon(
            Icons.skip_next,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
      Expanded(
        child: IconButton(
          icon: Icon(
            Icons.shuffle,
            color: Colors.lightBlueAccent,
          ),
          onPressed: () {},
        ),
      ),
    ],
  );
}
