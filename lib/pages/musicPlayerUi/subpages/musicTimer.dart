import 'package:flutter/material.dart';

Widget musicTimer(
    {required Size size,
    required Duration duration,
    required Duration position}) {
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
              "${position.toString().split(".")[0]}",
              style: TextStyle(color: Colors.white70),
            ),
            Text(
              "${duration.toString().split(".")[0]}",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    ],
  );
}
