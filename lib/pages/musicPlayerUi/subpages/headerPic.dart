import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

Widget headerPic(
    {required Size size,
    required String albumCover,
    required var albumCoverId}) {
  return QueryArtworkWidget(
    id: albumCoverId,
    type: ArtworkType.AUDIO,
    artworkBorder: BorderRadius.circular(10),
    artworkHeight: size.width * 0.9,
    artworkWidth: size.width * 0.9,
    nullArtworkWidget: Image.asset(
      albumCover,
      fit: BoxFit.cover,
      width: size.width * 0.9,
      height: size.width * 0.9,
    ),
  );
}
