import 'package:flutter/material.dart';

Widget headerPage({required Size size, required String albumCover}) {
  return Container(
    width: size.width * 0.9,
    height: size.width * 0.9,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        image: NetworkImage(albumCover),
        fit: BoxFit.cover,
      ),
    ),
  );
}
