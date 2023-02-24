import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/icons.dart';

class ButtonBarIcons extends StatelessWidget {
  ButtonBarIcons({super.key, required this.cameraController});
  final CameraController cameraController;
  bool isRecord = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CameraPageIcons(icon: Icons.image, onTap: () {}, color: Colors.black),
        Container(
          height: 65,
          width: 65,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 3),
            borderRadius: BorderRadius.circular(50),
          ),
          child: RawMaterialButton(
            onPressed: () {
              isRecord ? stopVideo() : takeVideo();
            },
            fillColor: Colors.red,
            shape: isRecord
                ? const RoundedRectangleBorder()
                : const CircleBorder(),
          ),
        ),
        CameraPageIcons(
          icon: Icons.flip_camera_android_outlined,
          onTap: () {},
          color: Colors.black,
        ),
      ],
    );
  }

  Future<void> takeVideo() async {
    await cameraController.startVideoRecording();
    isRecord = true;
  }

  Future<XFile> stopVideo() async {
    final XFile videoFile = await cameraController.stopVideoRecording();
    log(videoFile.path.toString());
    isRecord = false;
    return videoFile;
  }
}
