import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/instance_manager.dart';
import 'package:tuki_taki/global/constants.dart';
import 'package:tuki_taki/global/routing/custom_routing.dart';
import 'package:tuki_taki/global/routing/named_routes.dart';
import 'package:tuki_taki/modules/screens/reel/controllers/reel_cubit.dart';
import 'package:tuki_taki/modules/screens/reel/model/reel_state.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/icons.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({super.key});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late final VideoPlayerController videoPlayerController;
  final ReelCubit controller = Get.find<ReelCubit>();
  final List<String> speedValues = ['0.25x', '0.5x', '1x', '2x', '4x'];
  late final File _file;

  @override
  void initState() {
    videoPlayerInitialize();
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.pause();
    videoPlayerController.dispose();
    super.dispose();
  }

  void videoPlayerInitialize() {
    if (controller.state.videoFile != null) {
      videoPlayerController =
          VideoPlayerController.file(controller.state.videoFile!);
      videoPlayerController.initialize();
      videoPlayerController.play();
      videoPlayerController.setVolume(1);
      videoPlayerController.setLooping(true);
      _file = controller.state.videoFile!;
      return;
    }
    log("videoFile null in confirm screen");
  }

  void changeSpeed(String speed) {
    log(speed);
    final newSpeed = speed.replaceAll('x', '');
    final double controllerSpeed = double.parse(newSpeed);
    log(controllerSpeed.toString());
    videoPlayerController.setPlaybackSpeed(controllerSpeed);
    controller.increaseSpeed(speed: speed, path: _file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ReelCubit, ReelStateModel>(
        bloc: controller,
        builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Center(
                  child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: VideoPlayer(videoPlayerController))),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 50,
                  color: Colors.white.withOpacity(0.8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CameraPageIcons(
                          iconString: AppCustomIcons.songAdd,
                          onTap: () => controller.mergeVideoAndAudio()),
                      controller.state.songAddLoading
                          ? const CupertinoActivityIndicator(
                              color: Colors.white)
                          : Text(controller.state.songAddLoading ? "" : "Audio",
                              style: const TextStyle(color: Colors.white)),
                      CameraPageIcons(
                          iconString: AppCustomIcons.videoFilter,
                          onTap: () =>
                              CustomRouting.pushNamed(NamedRoutes.filter.path)),
                      const Text("Filters",
                          style: TextStyle(color: Colors.white)),
                      CameraPageIcons(
                          iconString: AppCustomIcons.videoTrim,
                          onTap: () =>
                              CustomRouting.pushNamed(NamedRoutes.trim.path)),
                      const Text("Trim", style: TextStyle(color: Colors.white)),
                      InkWell(
                        onTap: () => controller.speedSelectionTap(),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Center(
                                child: Text(
                              controller.state.speedValue,
                              style: const TextStyle(color: Colors.pink),
                            )),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        curve: Curves.linear,
                        duration: const Duration(milliseconds: 500),
                        height: state.speedTaped ? 180 : 0,
                        width: state.speedTaped ? 70 : 0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withOpacity(0.4)),
                        child: Wrap(
                          children: List.generate(
                            speedValues.length,
                            (index) => InkWell(
                                onTap: () => changeSpeed(speedValues[index]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    speedValues[index],
                                    style: TextStyle(
                                      color: state.showAnimation
                                          ? Colors.white
                                          : Colors.transparent,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
