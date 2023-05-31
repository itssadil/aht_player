import 'package:ahtplayer/pages/homePage/homPage.dart';
import 'package:ahtplayer/providers/visibleRefreshProvider.dart';
import 'package:ahtplayer/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:provider/provider.dart';

class PermissionChecker extends StatefulWidget {
  const PermissionChecker({Key? key}) : super(key: key);

  @override
  State<PermissionChecker> createState() => _PermissionCheckerState();
}

class _PermissionCheckerState extends State<PermissionChecker> {
  @override
  var visibleProvider;

  void initState() {
    super.initState();
    requestPermission(0);
  }

  void requestPermission(index) async {
    PermissionStatus status = await Permission.storage.status;

    if (status.isGranted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else if (status.isDenied) {
      status = await Permission.storage.request();
      if (status.isGranted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    }
    if (status.isPermanentlyDenied && index == 1) {
      visibleProvider =
          Provider.of<VisibleRefreshProvider>(context, listen: false);
      if (PermissionHandlerPlatform.instance != null) {
        await PermissionHandlerPlatform.instance.openAppSettings();
      } else {
        print('Could not open app settings');
      }
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      visibleProvider.changeVisibleRefresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title(appTitle: 'AHT Player'),
        centerTitle: true,
        foregroundColor: Colors.lightBlue,
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Read files permission",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 10),
          Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Grant storage permission to access local files for seamless loading and utilization within the application.",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 10),
          Consumer<VisibleRefreshProvider>(
            builder: (context, isVisibleRefresh, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => requestPermission(1),
                    child: Text("Allow access"),
                  ),
                  Visibility(
                    visible: isVisibleRefresh.isVisibleRefresh,
                    child: SizedBox(width: 10),
                  ),
                  Visibility(
                    visible: isVisibleRefresh.isVisibleRefresh,
                    child: ElevatedButton(
                      onPressed: () => requestPermission(1),
                      child: Text("Refresh"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
