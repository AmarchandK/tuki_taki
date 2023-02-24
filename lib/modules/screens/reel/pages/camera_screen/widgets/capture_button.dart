
import 'package:flutter/material.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/icons.dart';

class ButtonBarIcons extends StatelessWidget {
  const ButtonBarIcons({
    super.key,
  });

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
            onPressed: () {},
            fillColor: Colors.red,
            shape: const CircleBorder(),
          ),
        ),
        CameraPageIcons(
          icon: Icons.swap_horiz_sharp,
          onTap: () {},
          color: Colors.black,
        ),
      ],
    );
  }
}
