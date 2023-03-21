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

class _ConfirmScreenState extends State<ConfirmScreen>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController videoPlayerController;
  final ReelCubit controller = Get.find<ReelCubit>();
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    videoPlayerInitialize();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 1, end: 2).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.pause();
    videoPlayerController.dispose();
    super.dispose();
  }

  void videoPlayerInitialize() {
    videoPlayerController =
        VideoPlayerController.file(controller.state.videoFile!);
    videoPlayerController.initialize();
    // videoPlayerController.play();
    // videoPlayerController.setVolume(1);
    // videoPlayerController.setLooping(true);
  }

  bool isSpeedTaped = false;
  void _increaseSpeed() {
    // videoPlayerController.setPlaybackSpeed(2);
    // controller.increaseSpeed();
    speedTaping();
  }

  void speedTaping() {
    isSpeedTaped = !isSpeedTaped;
    setState(() {});
    isSpeedTaped ? _controller.forward() : _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ReelCubit, ReelStateModel>(
        bloc: controller,
        builder: (context, state) {
          return Stack(
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(videoPlayerController),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(onPressed: () {}, child: const Text("Done")),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 250,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.7),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      controller.state.songAddLoading
                          ? const CupertinoActivityIndicator(
                              color: Colors.white)
                          : CameraPageIcons(
                              iconString: AppCustomIcons.songAdd,
                              onTap: () => controller.mergeVideoAndAudio(),
                            ),
                      Text(controller.state.songAddLoading ? "" : "Audio",
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
                      IconButton(
                        onPressed: _increaseSpeed,
                        icon:
                            const Icon(Icons.fast_forward, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
