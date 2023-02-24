import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                cameraPageICons(
                                    icon: Icons.flash_on_outlined,
                                    onTap: () {}),
                                const Spacer(),
                                cameraPageICons(
                                    icon: Icons.close_outlined, onTap: () {}),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                cameraPageICons(
                                    icon: Icons.music_note, onTap: () {}),
                                cameraPageICons(
                                    icon: Icons.movie_filter_outlined,
                                    onTap: () {}),
                                cameraPageICons(
                                    icon: Icons.timer_sharp, onTap: () {}),
                                cameraPageICons(
                                    icon: Icons.one_x_mobiledata_sharp,
                                    onTap: () {}),
                                cameraPageICons(
                                    icon: Icons.grid_view_outlined,
                                    onTap: () {}),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 140,
                        child: DefaultTabController(
                          length: 2,
                          child: TabBar(
                              indicatorColor: Colors.transparent,
                              tabs: [tabs('POST'), tabs('REEL')]),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      cameraPageICons(
                          icon: Icons.image, onTap: () {}, color: Colors.black),
                      Container(
                        height: 65,
                        width: 65,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red, width: 3),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: RawMaterialButton(
                          onPressed: () {},
                          fillColor: Colors.red,
                          shape: const CircleBorder(),
                        ),
                      ),
                      cameraPageICons(
                        icon: Icons.swap_horiz_sharp,
                        onTap: () {},
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10)
                ],
              )
            : const Center(child: CupertinoActivityIndicator()),
      ),
    );
  }

  Container tabs(String name) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2.0), topRight: Radius.circular(2.0)),
      ),
      child: Text(
        name,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  IconButton cameraPageICons(
      {required IconData icon, required void Function() onTap, Color? color}) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: color ?? Colors.white),
    );
  }
}
