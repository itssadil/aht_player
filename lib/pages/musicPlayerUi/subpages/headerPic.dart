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
    artworkQuality: FilterQuality.high,
    nullArtworkWidget: Container(
      width: size.width * 0.9,
      height: size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(albumCover),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
