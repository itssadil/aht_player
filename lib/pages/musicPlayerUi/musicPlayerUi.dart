import 'dart:developer';

import 'package:ahtplayer/providers/durPosProvider.dart';
import 'package:ahtplayer/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';

import 'subpages/bottomSheetSongs.dart';
import 'subpages/headerPic.dart';
import 'subpages/musicTimer.dart';
import 'subpages/playIcons.dart';
import 'subpages/songTitle.dart';

class MusicPlayerUI extends StatefulWidget {
  // var title;
  // var subTitle;
  // var songUri;
  var songModel;
  final AudioPlayer audioPlayer;
  // var albumCoverId;
  MusicPlayerUI(
    // this.title,
    // this.subTitle,
    // this.songUri,
    this.songModel,
    this.audioPlayer,
    // this.albumCoverId,
  );

  @override
  State<MusicPlayerUI> createState() => _MusicPlayerUIState();
}

class _MusicPlayerUIState extends State<MusicPlayerUI> {
  var myProvider;
  @override
  void initState() {
    super.initState();
    playSong(widget.songModel.uri);
  }

  playSong(songUri) {
    myProvider = Provider.of<DurPosProvider>(context, listen: false);
    try {
      widget.audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(songUri),
          tag: MediaItem(
            id: 'widget.songModel.id',
            album: widget.songModel.album,
            title: widget.songModel.displayNameWOExt,
            artUri: Uri.parse('https://example.com/albumart.jpg'),
          ),
        ),
      );
      widget.audioPlayer.play();
    } on Exception {
      log("Error persing song");
    }

    widget.audioPlayer.durationStream.listen((d) {
      myProvider.changeDurationValue(d);
    });
    widget.audioPlayer.positionStream.listen((d) {
      myProvider.changePositionValue(d);
    });
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  String appTitle = "AHT Player";

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        appTitle = "Music off at ${pickedTime.format(context)}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final String albumCover = "assets/img/albumCover.jpg";
    return Scaffold(
      backgroundColor: Color(0xff001BF6),
      appBar: AppBar(
        title: title(appTitle: appTitle),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _selectTime(context),
            icon: Icon(Icons.timer_sharp),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(albumCover),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Divider(color: Colors.white54),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    headerPic(
                      size: size,
                      albumCover: albumCover,
                      albumCoverId: widget.songModel.id,
                    ),
                    songTitle(size: size, songModel: widget.songModel),
                    musicTimer(size: size, audioPlayer: widget.audioPlayer),
                    PlayIcons(widget.songModel, widget.audioPlayer),
                  ],
                ),
              ),
              allBtmSongs(),
            ],
          ),
        ),
      ),
    );
  }
}
