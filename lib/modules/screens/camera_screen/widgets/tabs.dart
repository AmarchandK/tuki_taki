
import 'package:flutter/material.dart';

class TukiTakiTabs extends StatelessWidget {
  const TukiTakiTabs({required this.name, super.key});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2.0), topRight: Radius.circular(2.0)),
      ),
      child: Text(
        name,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
