import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/icons.dart';

class TopBarIcons extends StatelessWidget {
  const TopBarIcons({super.key, required this.cameraController});
  final CameraController cameraController;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          const SizedBox(width: 10),
          CameraPageIcons(icon: Icons.flash_on_outlined, onTap: () {}),
          const Spacer(),
          CameraPageIcons(icon: Icons.close_outlined, onTap: () {}),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
