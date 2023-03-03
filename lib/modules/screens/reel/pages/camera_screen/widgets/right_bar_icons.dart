import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:tuki_taki/modules/screens/reel/controllers/reel_cubit.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/icons.dart';

class RightBarIcons extends StatelessWidget {
  RightBarIcons({super.key});
  final ReelCubit controller = Get.find<ReelCubit>();
  void _onTimerPress() {
    controller.state.functionLoading ? null : controller.timerPressed();
  }

  void _onTimOutPress() {
    controller.timeOutCalled(15);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CameraPageIcons(icon: Icons.music_note, onTap: () {}),
          CameraPageIcons(icon: Icons.timer_3_outlined, onTap: _onTimerPress),
          CameraPageIcons(icon: Icons.timer_outlined, onTap: _onTimOutPress),
        ],
      ),
    );
  }
}
