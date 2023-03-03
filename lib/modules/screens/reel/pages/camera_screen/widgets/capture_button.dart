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
    controller.state.isRecording
        ? controller.stopVideo()
        : controller.takeVideo();
  }

  void _switchCamera() {
    controller.flipCamera(controller.state.initialCamera ? 1 : 0);
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
                onTap: _switchCamera,
                color: Colors.black),
          ],
        );
      },
    );
  }
}
