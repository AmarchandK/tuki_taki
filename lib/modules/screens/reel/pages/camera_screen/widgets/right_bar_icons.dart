
import 'package:flutter/material.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/icons.dart';

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