import 'package:camera/camera.dart';
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
  final BorderSide borderSide = const BorderSide(color: Colors.red, width: 2);
  final double targetRatio = 4 / 3;

  final ReelCubit controller = ReelCubit();
  int layoutPositon = 0;
  bool layoutRecording = false;

  @override
  void initState() {
    Get.put(controller, permanent: true);
    controller.startCamera(0);
    controller.createGrid(2);
    super.initState();
  }

  void videoPlay({required VideoPlayerController videoPlayerController}) async {
    if (videoPlayerController.value.isPlaying) {
      await videoPlayerController.pause();
    } else {
      await videoPlayerController.play();
      await videoPlayerController.setLooping(true);
    }
  }

  void handleButton() {
    if (!layoutRecording) {
      controller.startLayoutCamera(layoutPositon);
      layoutRecording = !layoutRecording;
    } else {
      controller.stopLayoutVideo(layoutPositon);
      layoutPositon++;
      layoutRecording = !layoutRecording;
      if (controller.state.cameraLaouts.length == layoutPositon) {
        layoutPositon = 0;
      }
    }
  }

  bool maintainAspectRatio(double width, double height) {
    final double deviceRatio = width / height;
    return deviceRatio > targetRatio;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder<ReelCubit, ReelStateModel>(
      bloc: controller,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () {
                    controller.onLayoutDone();
                  },
                  child:
                      const Text('Done', style: TextStyle(color: Colors.white)))
            ],
          ),
          body: state.isCameraControllerInitialsed || state.isRecording
              ? ListView.builder(
                  padding: const EdgeInsets.all(8),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.cameraLaouts.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => videoPlay(
                        videoPlayerController:
                            state.cameraLaouts[index].videoPlayerController!),
                    child: Container(
                      height: size.height / 2.3,
                      decoration: BoxDecoration(
                          border: index == 0
                              ? Border(
                                  top: borderSide,
                                  left: borderSide,
                                  right: borderSide)
                              : Border.all(color: Colors.red, width: 2)),
                      // child: maintainAspectRatio(
                      //         double.infinity, double.infinity)
                      //     ? OverflowBox(
                      //         maxWidth: size.height * targetRatio,
                      //         child: state.cameraLaouts[index].cameraRecording
                      //             ? CameraPreview(controller.cameraController)
                      //             : state.cameraLaouts[index].recorded
                      //                 ? VideoPlayer(controller
                      //                     .state
                      //                     .cameraLaouts[index]
                      //                     .videoPlayerController!)
                      //                 : const Center(
                      //                     child: CupertinoActivityIndicator()),
                      //       ):
                      child: AspectRatio(
                        aspectRatio: targetRatio,
                        child: state.cameraLaouts[index].cameraRecording
                            ? CameraPreview(controller.cameraController)
                            : state.cameraLaouts[index].recorded
                                ? VideoPlayer(state
                                    .cameraLaouts[index].videoPlayerController!)
                                : const Center(
                                    child: CupertinoActivityIndicator()),
                      ),
                    ),
                  ),
                )
              : const Center(child: CupertinoActivityIndicator()),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
              onPressed: () => handleButton(), backgroundColor: Colors.red),
        );
      },
    );
  }
}
