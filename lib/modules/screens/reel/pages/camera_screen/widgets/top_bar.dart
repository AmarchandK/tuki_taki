import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:tuki_taki/modules/screens/reel/controllers/reel_cubit.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/icons.dart';

class TopBarIcons extends StatelessWidget {
  TopBarIcons({super.key});

  final ReelCubit controller = Get.find<ReelCubit>();
  bool flashOn = false;

  void selectFlash() async {
    flashOn = !flashOn;
    await controller.flashControle(flashOn ? FlashMode.torch : FlashMode.off);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          const SizedBox(width: 10),
          CameraPageIcons(icon: Icons.flash_on_outlined, onTap: selectFlash),
          const Spacer(),
          Text(
            controller.state.timeOut >= 0 ? "15 s" : '',
            style: const TextStyle(color: Colors.red, fontSize: 25),
          ),
          const Spacer(),
          CameraPageIcons(icon: Icons.close_outlined, onTap: () {}),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
