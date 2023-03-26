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
  final ReelCubit controller = Get.put(ReelCubit());
  final List<String> speedValues = ['3x', '.5x', '2x', '3x'];
  late final File? _file;

  @override
  void initState() {
    _file = controller.state.videoFile;
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
      // videoPlayerController.play();
      videoPlayerController.setVolume(1);
      videoPlayerController.setLooping(true);
      return;
    }
    log("videoFile null in confirm screen");
  }

  String _speedSelection(String speed) {
    switch (speed) {
      case "2x":
        return "0.5";
      case "4x":
        return "0.25";
      case "0.5x":
        return "2";
      case "0.25x":
        return "4";
      default:
        return "0";
    }
  }

  void changeSpeed() {
    final String speedValue = controller.state.speedValue;
    log(speedValue);
    videoPlayerController.setPlaybackSpeed(2);
    final String command = _speedSelection(speedValue);
    controller.increaseSpeed(speed: command, path: _file!.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<ReelCubit, ReelStateModel>(
        bloc: controller,
        builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // Center(child: VideoPlayer(videoPlayerContr oller)),
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
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 480,
                right: 5,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        curve: Curves.linear,
                        duration: const Duration(milliseconds: 500),
                        height: state.speedTaped ? 80 : 0,
                        width: state.speedTaped ? 70 : 0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withOpacity(0.4)),
                        child: Wrap(
                          children: List.generate(
                            speedValues.length,
                            (index) => InkWell(
                                onTap: changeSpeed,
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
                      ),
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
