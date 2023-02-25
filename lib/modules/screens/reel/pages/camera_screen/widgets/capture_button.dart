import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/instance_manager.dart';
import 'package:tuki_taki/modules/screens/reel/controllers/reel_cubit.dart';
import 'package:tuki_taki/modules/screens/reel/model/reel_state.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/icons.dart';

class ButtonBarIcons extends StatelessWidget {
  ButtonBarIcons({super.key});
  final ReelCubit controller = Get.find<ReelCubit>();

  void _handleOnPress() {
    controller.state.isRecording ? stopVideo() : takeVideo();
  }

  Future<void> takeVideo() async {
    await controller. cameraController.startVideoRecording();
    controller.setRecordingAs(true);
  }

  Future<void> stopVideo() async {
    final XFile videoFile = await  controller. cameraController.stopVideoRecording();
    controller.setRecordingAs(false);
    log(videoFile.path.toString());
    controller.setVideo(videoFile.path);
  }

  void switchCamera(int i) async {
    // cameraController = controller.switchCamera(i);
    // controller.setCameraAsInitialised(false);
    // await cameraController.initialize();
    // controller.setCameraAsInitialised(true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReelCubit, ReelStateModel>(
      bloc: controller,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CameraPageIcons(
                icon: Icons.image,
                onTap: () => controller.pickVideo(),
                color: Colors.black),
            Container(
              height: 65,
              width: 65,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 3),
                borderRadius: BorderRadius.circular(50),
              ),
              child: RawMaterialButton(
                onPressed: _handleOnPress,
                fillColor: Colors.red,
                shape: state.isRecording
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))
                    : const CircleBorder(),
              ),
            ),
            CameraPageIcons(
              icon: Icons.flip_camera_android_outlined,
              onTap: () => switchCamera(1),
              color: Colors.black,
            ),
          ],
        );
      },
    );
  }
}
