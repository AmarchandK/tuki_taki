import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/instance_manager.dart';
import 'package:tuki_taki/modules/screens/reel/controllers/reel_cubit.dart';
import 'package:tuki_taki/modules/screens/reel/model/reel_state.dart';
import 'package:video_player/video_player.dart';

class LayoutCamera extends StatefulWidget {
  const LayoutCamera({super.key});

  @override
  State<LayoutCamera> createState() => _LayoutCameraState();
}

class _LayoutCameraState extends State<LayoutCamera> {
  BorderSide borderSide = const BorderSide(color: Colors.red, width: 3);
  final ReelCubit controller = ReelCubit();
  late VideoPlayerController videoPlayerController1;
  late File? file;
  bool one = false;
  bool two = false;

  @override
  void initState() {
    Get.put(controller);
    controller.startCamera(0);
    controller.createGrid(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<ReelCubit, ReelStateModel>(
      bloc: controller,
      builder: (context, state) {
        return Scaffold(
          body: state.isCameraControllerInitialsed || state.isRecording
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.state.cameraLaouts.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      !one ? recordCamera(index) : videoPlay(index);
                      one = !one;
                    },
                    child: Container(
                      height: size.height / 2.1,
                      decoration:
                          BoxDecoration(border: Border(top: borderSide)),
                      child:
                          controller.state.cameraLaouts[index].cameraRecording
                              ? controller.cameraController.buildPreview()
                              : controller.state.cameraLaouts[index].recorded
                                  ? VideoPlayer(videoPlayerController1)
                                  : const Center(
                                      child: CupertinoActivityIndicator()),
                    ),
                  ),
                )
              : const Center(child: CupertinoActivityIndicator()),
        );
      },
    );
  }

 void videoPlay(int index) async {
    await videoPlayerController1.play();
    videoPlayerController1.setVolume(1);
  }

 void recordCamera(int index) async {
    try {
      controller.startLayoutCamera(index);
      await Future.delayed(const Duration(seconds: 5));
      final String path = await controller.stopLayoutVideo(index);
      file = File(path);
      videoPlayerController1 = VideoPlayerController.file(file!);
      await videoPlayerController1.initialize();
      videoPlayerController1.play();
      videoPlayerController1.setLooping(true);
      setState(() {});
    } catch (e) {
      log("error on video play =================$e");
    }
  }
}
