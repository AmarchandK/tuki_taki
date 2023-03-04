import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tuki_taki/global/constants.dart';
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
          CameraPageIcons(
              iconString: AppCustomIcons.flashOn, onTap: selectFlash),
          const Spacer(),
          Text(
            controller.state.timeOut >= 0
                ? controller.state.timeOut.toString()
                : '',
            style: const TextStyle(color: Colors.red, fontSize: 25),
          ),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
