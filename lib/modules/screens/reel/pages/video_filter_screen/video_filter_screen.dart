import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:tapioca/tapioca.dart';
import 'package:tuki_taki/modules/screens/reel/controllers/reel_cubit.dart';

class VideoFilterScreen extends StatefulWidget {
  const VideoFilterScreen({super.key});

  @override
  State<VideoFilterScreen> createState() => _VideoFilterScreenState();
}

class _VideoFilterScreenState extends State<VideoFilterScreen> {
  final ReelCubit controller = Get.find<ReelCubit>();
  final tapiocaBalls = [
    TapiocaBall.filter(Filters.pink, 0),
    TapiocaBall.filter(Filters.blue, 0),
    TapiocaBall.filter(Filters.white, 0) 
  ];

  duna() {
    final String path = controller.state.videoFile!.path;
    final Cup cup = Cup(Content(path), tapiocaBalls);
    cup.suckUp(path).then((_) {
      log('Video Filter Processing');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('-----------Filter--------------'),
    );
  }
}
