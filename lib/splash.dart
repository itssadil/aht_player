import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

import 'pages/homePage/homPage.dart';
import 'permissionChecker.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    requestPermission();
  }

  void requestPermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isGranted) {
      Timer(
        Duration(seconds: 2),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        },
      );
    } else {
      Timer(
        Duration(seconds: 2),
        () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PermissionChecker(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Lottie.asset(
                "assets/lottie/splashAni.json",
              ),
            ),
            Text(
              "AHT Player",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
