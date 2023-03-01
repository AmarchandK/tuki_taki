import 'package:flutter/material.dart';

class CameraPageIcons extends StatelessWidget {
  const CameraPageIcons(
      {super.key, required this.icon, required this.onTap, this.color});
  final IconData icon;
  final void Function() onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: color ?? Colors.white,
          size: 27,
        ),
      ),
    );
  }
}
