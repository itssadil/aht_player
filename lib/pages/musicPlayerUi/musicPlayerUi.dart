import 'dart:developer';

import 'package:ahtplayer/providers/durPosProvider.dart';
import 'package:ahtplayer/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'subpages/bottomSheetSongs.dart';
import 'subpages/headerPic.dart';
import 'subpages/musicTimer.dart';
import 'subpages/playIcons.dart';
import 'subpages/songTitle.dart';

class MusicPlayerUI extends StatefulWidget {
  final List<SongModel> songModel;
  final AudioPlayer audioPlayer;
  int songIndex;

  MusicPlayerUI(
    this.songModel,
    this.audioPlayer,
    this.songIndex,
  );

  @override
  State<MusicPlayerUI> createState() => _MusicPlayerUIState();
}

class _MusicPlayerUIState extends State<MusicPlayerUI> {
  var myProvider;
  List<AudioSource> songList = [];
  // int songIndex = widget.songIndex;

  @override
  void initState() {
    super.initState();
    // playSong(widget.songModel.uri);
    playSong();
  }

  playSong() {
    myProvider = Provider.of<DurPosProvider>(context, listen: false);
    try {
      widget.songModel.forEach((element) {
        songList.add(
          AudioSource.uri(
            Uri.parse(element.uri!),
            tag: MediaItem(
              id: element.id.toString(),
              album: element.album,
              title: element.displayNameWOExt,
              artUri: Uri.parse('https://example.com/albumart.jpg'),
            ),
          ),
        );
      });
      widget.audioPlayer.setAudioSource(
        ConcatenatingAudioSource(children: songList),
        initialIndex: widget.songIndex,
      );
    } on Exception {
      log("Error persing song");
    }
    widget.audioPlayer.play();

    widget.audioPlayer.durationStream.listen((d) {
      myProvider.changeDurationValue(d);
    });
    widget.audioPlayer.positionStream.listen((d) {
      myProvider.changePositionValue(d);
    });

    listenToSongIndex();
  }

  void listenToSongIndex() {
    widget.audioPlayer.currentIndexStream.listen((event) {
      setState(() {
        if (event != null) {
          widget.songIndex = event;
        }
      });
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
      body: Stack(
        children: [
          Positioned(
            child: Opacity(
              opacity: 0.3,
              child: QueryArtworkWidget(
                id: widget.songModel[widget.songIndex].id,
                type: ArtworkType.AUDIO,
                artworkBorder: BorderRadius.circular(10),
                artworkHeight: size.height,
                artworkWidth: size.width,
                nullArtworkWidget: Image.asset(
                  albumCover,
                  fit: BoxFit.cover,
                  width: size.width,
                  height: size.height,
                ),
              ),
            ),
          ),
          Container(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Divider(color: Colors.white54),
                  // Text("${widget.songModel}"),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        headerPic(
                          size: size,
                          albumCover: albumCover,
                          albumCoverId: widget.songModel[widget.songIndex].id,
                        ),
                        songTitle(
                          size: size,
                          songModel: widget.songModel,
                          songIndex: widget.songIndex,
                        ),
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
        ],
      ),
    );
  }
}
