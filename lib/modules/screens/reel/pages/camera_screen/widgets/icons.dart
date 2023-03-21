import 'package:flutter/material.dart';

class CameraPageIcons extends StatelessWidget {
  const CameraPageIcons(
      {super.key, required this.iconString, required this.onTap});
  final String iconString;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
          padding: const EdgeInsets.all(5.0),
          child:
              Image.asset(iconString, height: 30, width: 30, fit: BoxFit.fill)),
    );
  }
}
