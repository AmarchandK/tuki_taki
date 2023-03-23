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
  BorderSide borderSide = const BorderSide(color: Colors.red, width: 3);
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
                  child: const Text(
                    'Done',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          body: state.isCameraControllerInitialsed || state.isRecording
              ? ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 5),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.state.cameraLaouts.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => videoPlay(
                        index: index,
                        videoPlayerController: controller
                            .state.cameraLaouts[index].videoPlayerController!),
                    child: AspectRatio(
                      aspectRatio:
                          controller.cameraController.value.aspectRatio,
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                                Border(top: borderSide, bottom: borderSide)),
                        child:
                            controller.state.cameraLaouts[index].cameraRecording
                                ? cameraScreen(size)
                                : controller.state.cameraLaouts[index].recorded
                                    ? VideoPlayer(controller
                                        .state
                                        .cameraLaouts[index]
                                        .videoPlayerController!)
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
            onPressed: () => handleButton(),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }

  void videoPlay(
      {required int index,
      required VideoPlayerController videoPlayerController}) async {
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
    }
  }

  Widget cameraScreen(Size size) {
    return Transform.scale(
      scale: 1.0,
      child: AspectRatio(
        aspectRatio: 3.0 / 4.0,
        child: OverflowBox(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: SizedBox(
              width: size.width,
              height:
                  size.height / controller.cameraController.value.aspectRatio,
              child: Stack(
                children: <Widget>[
                  CameraPreview(controller.cameraController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
