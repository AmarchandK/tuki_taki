import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:tuki_taki/global/constants.dart';
import 'package:tuki_taki/global/routing/custom_routing.dart';
import 'package:tuki_taki/global/routing/named_routes.dart';
import 'package:tuki_taki/modules/screens/reel/controllers/reel_cubit.dart';
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
  @override
  void initState() {
    videoPlayerInitialize();
    super.initState();
  }

  void videoPlayerInitialize() {
    videoPlayerController =
        VideoPlayerController.file(controller.state.videoFile!);
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setVolume(1);
    videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    videoPlayerController.pause();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.7),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CameraPageIcons(
                    iconString: AppCustomIcons.songAdd,
                    onTap: () => controller.mergeVideoAndAudio(),
                  ),
                  const Text("Audio", style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 10),
                  CameraPageIcons(
                      iconString: AppCustomIcons.videoFilter,
                      onTap: () =>
                          CustomRouting.pushNamed(NamedRoutes.filter.path)),
                  const Text("Filters", style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 10),
                  CameraPageIcons(
                      iconString: AppCustomIcons.videoTrim,
                      onTap: () =>
                          CustomRouting.pushNamed(NamedRoutes.trim.path)),
                  const Text("Trim", style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
