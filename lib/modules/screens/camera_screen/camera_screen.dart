import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuki_taki/modules/screens/camera_screen/widgets/capture_button.dart';
import 'package:tuki_taki/modules/screens/camera_screen/widgets/icons.dart';
import 'package:tuki_taki/modules/screens/camera_screen/widgets/right_bar.dart';
import 'package:tuki_taki/modules/screens/camera_screen/widgets/tabs.dart';

class CameraReel extends StatefulWidget {
  const CameraReel({super.key});

  @override
  State<CameraReel> createState() => _CameraReelState();
}

class _CameraReelState extends State<CameraReel> {
  List<CameraDescription> cameraList = [];
  late final CameraController cameraController;
  @override
  void initState() {
    startCamera();
    super.initState();
  }

  void startCamera() async {
    cameraList = await availableCameras();
    cameraController = CameraController(cameraList[0], ResolutionPreset.medium);
    cameraController.initialize().then((value) {
      if (!mounted) {
        log("Camera Not Mounted");
        return;
      }
      setState(() {});
    }).catchError((error) {
      log(error.toString());
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: cameraController.value.isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height - 160,
                    child: CameraPreview(
                      cameraController,
                      child: Stack(
                        fit: StackFit.expand,
                        children: const [
                          TopBarIcons(),
                          RightBarIcons(),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      SizedBox(
                        width: 140,
                        child: DefaultTabController(
                          length: 2,
                          child: TabBar(
                              indicatorColor: Colors.transparent,
                              tabs: [
                                TukiTakiTabs(name: 'POST'),
                                TukiTakiTabs(name: 'REEL')
                              ]),
                        ),
                      ),
                    ],
                  ),
                  const ButtonBarIcons(),
                  const SizedBox(height: 10)
                ],
              )
            : const Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}

class RightBarIcons extends StatelessWidget {
  const RightBarIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CameraPageIcons(icon: Icons.music_note, onTap: () {}),
          CameraPageIcons(icon: Icons.movie_filter_outlined, onTap: () {}),
          CameraPageIcons(icon: Icons.timer_sharp, onTap: () {}),
          CameraPageIcons(icon: Icons.one_x_mobiledata_sharp, onTap: () {}),
          CameraPageIcons(icon: Icons.grid_view_outlined, onTap: () {}),
        ],
      ),
    );
  }
}
