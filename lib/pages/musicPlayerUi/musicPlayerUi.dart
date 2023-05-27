import 'package:ahtplayer/widgets/title.dart';
import 'package:flutter/material.dart';

import 'subpages/bottomSheetSongs.dart';
import 'subpages/headerPic.dart';
import 'subpages/musicTimer.dart';
import 'subpages/playIcons.dart';
import 'subpages/songTitle.dart';

class MusicPlayerUI extends StatefulWidget {
  const MusicPlayerUI({Key? key}) : super(key: key);

  @override
  State<MusicPlayerUI> createState() => _MusicPlayerUIState();
}

class _MusicPlayerUIState extends State<MusicPlayerUI> {
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
    final String albumCover =
        "https://img.freepik.com/free-vector/app-development-banner_33099-1720.jpg";
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
            image: NetworkImage(albumCover),
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
                    headerPage(size: size, albumCover: albumCover),
                    songTitle(size: size),
                    musicTimer(size: size),
                    playIcons(),
                  ],
                ),
              ),
              allSongs(),
            ],
          ),
        ),
      ),
    );
  }
}
