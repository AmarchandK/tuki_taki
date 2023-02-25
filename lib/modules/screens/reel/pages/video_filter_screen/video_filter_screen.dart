import 'package:flutter/material.dart';
import 'package:tapioca/tapioca.dart';

class VideoFilterScreen extends StatefulWidget {
  const VideoFilterScreen({super.key});

  @override
  State<VideoFilterScreen> createState() => _VideoFilterScreenState();
}

class _VideoFilterScreenState extends State<VideoFilterScreen> {
  final tapiocaBalls = [
    TapiocaBall.filter(Filters.pink, 0),
    TapiocaBall.filter(Filters.blue, 0),
    TapiocaBall.filter(Filters.white, 0),
  ];

  duna() {
    final cup = Cup(Content('videoPath'), tapiocaBalls);
    cup.suckUp('').then((_) {
      print("finish processing");
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('-----------Filter--------------'),
    );
  }
}
