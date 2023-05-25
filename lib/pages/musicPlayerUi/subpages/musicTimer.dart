import 'package:flutter/material.dart';

Widget musicTimer({required Size size}) {
  return Column(
    children: [
      Slider(
        value: 0.2,
        onChanged: (double value) {},
        activeColor: Colors.lightBlueAccent,
        inactiveColor: Colors.blue.withOpacity(0.8),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "01:37",
              style: TextStyle(color: Colors.white70),
            ),
            Text(
              "04:56",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    ],
  );
}
