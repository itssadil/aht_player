import 'dart:async';
import 'dart:developer';

import 'package:ahtplayer/providers/durPosProvider.dart';
import 'package:ahtplayer/providers/footerPlayingProvider.dart';
import 'package:ahtplayer/providers/musicPlayerTitleProvider.dart';
import 'package:ahtplayer/providers/playPauseProvider.dart';
import 'package:ahtplayer/providers/timerVisibleProvider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import 'subpages/footerSongs.dart';
import 'subpages/headerPic.dart';
import 'subpages/musicTimer.dart';
import 'subpages/playIcons.dart';
import 'subpages/songTitle.dart';

class MusicPlayerUI extends StatefulWidget {
  final List<SongModel> songModel;
  final AudioPlayer audioPlayer;
  int songIndex;
  var seekTo;
  bool isFromFooter;

  MusicPlayerUI(
    this.songModel,
    this.audioPlayer,
    this.songIndex,
    this.seekTo,
    this.isFromFooter,
  );

  @override
  State<MusicPlayerUI> createState() => _MusicPlayerUIState();
}

class _MusicPlayerUIState extends State<MusicPlayerUI> {
  var myProvider;
  var myMusicPlayerTitle;
  var myPlayPauseProvider;
  var myTimerVisibleProvider;
  var footerProvider;
  late Timer watchTimer;
  late Duration difference;
  List<AudioSource> songList = [];
  bool isSelectTime = false;

  @override
  void initState() {
    super.initState();
    playSong();
  }

  /*====================================================================
                            Audio Playing Function
  ====================================================================*/

  playSong() {
    myProvider = Provider.of<DurPosProvider>(context, listen: false);
    footerProvider = Provider.of<FooterPlayingProvider>(context, listen: false);

    if (widget.isFromFooter != true) {
      try {
        widget.songModel.forEach((element) {
          songList.add(
            AudioSource.uri(
              Uri.parse(element.uri!),
              tag: MediaItem(
                id: element.id.toString(),
                album: element.album,
                title: element.displayNameWOExt,
                artUri: Uri.parse(
                    "https://raw.githubusercontent.com/itssadil/aht_player/master/photo-1680357981460-f00398bafd42.jpg"),
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
    } else {
      widget.audioPlayer.seek(widget.seekTo);
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
          footerProvider.changePlayingIndex(event);
        }
      });
    });
  }

  /*====================================================================
                           Sleeping Timer Function
  ====================================================================*/

  TimeOfDay selectedTime = TimeOfDay.now();
  String appTitle = "AHT Player";

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      myMusicPlayerTitle =
          Provider.of<MusicPlayerTitle>(context, listen: false);
      myPlayPauseProvider = Provider.of<PlayPause>(context, listen: false);
      myTimerVisibleProvider =
          Provider.of<TimerVisible>(context, listen: false);

      final dateTime2 = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, pickedTime.hour, pickedTime.minute);
      final currentTime = TimeOfDay.fromDateTime(DateTime.now());
      final dateTime1 = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, currentTime.hour, currentTime.minute);
      difference = dateTime2.difference(dateTime1);

      int hours = difference.inHours;
      int minutes = difference.inMinutes.remainder(60) - 1;
      int second = 59;

      watchTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (second < 0) {
          second = 59;
          minutes = minutes - 1;
        }
        if (minutes == 60) {
          minutes = 59;
          hours = hours + 1;
        }
        if (minutes < 0) {
          minutes = 59;
          hours = hours - 1;
        }
        final formattedDuration =
            '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';

        appTitle = "$formattedDuration";
        if (hours < 0) {
          timer.cancel();
          appTitle = "00:00:00";
          widget.audioPlayer.pause();
        }
        myMusicPlayerTitle.changeTimerWatch(appTitle);

        if (widget.audioPlayer.playing == false &&
            myPlayPauseProvider.playPauseIcon == Icons.pause_circle) {
          myPlayPauseProvider.changePlayPauseIcon();
          myTimerVisibleProvider.changeHomeValue();
        }

        second--;
      });

      myTimerVisibleProvider.changeHomeValue();
    }
  }

  stopTimer() {
    myMusicPlayerTitle = Provider.of<MusicPlayerTitle>(context, listen: false);
    if (watchTimer.isActive) {
      watchTimer.cancel();
      appTitle = "AHT Player";
      myMusicPlayerTitle.changeTimerWatch(appTitle);
    }
    myTimerVisibleProvider.changeHomeValue();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final String albumCover = "assets/img/albumCover.jpg";

    return Scaffold(
      backgroundColor: Color(0xff001BF6),
      appBar: AppBar(
        title: Consumer<MusicPlayerTitle>(
          builder: (context, value, child) {
            return Text(value.appTitle);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Consumer<TimerVisible>(
            builder: (context, isTimerVisible, child) {
              return Visibility(
                visible: isTimerVisible.isTimerVisible,
                child: IconButton(
                  onPressed: () => _selectTime(context),
                  icon: Icon(Icons.timer_sharp),
                ),
              );
            },
          ),
          Consumer<TimerVisible>(
            builder: (context, isTimerVisible, child) {
              return Visibility(
                visible: !isTimerVisible.isTimerVisible,
                child: IconButton(
                  onPressed: () => stopTimer(),
                  icon: Icon(Icons.cancel_outlined),
                ),
              );
            },
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
                        PlayIcons(widget.songModel, widget.songIndex,
                            widget.audioPlayer),
                      ],
                    ),
                  ),
                  footerSongs(widget.audioPlayer),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
