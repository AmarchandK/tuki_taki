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
    videoPlayerController =
        VideoPlayerController.file(controller.state.videoFile!);
    videoPlayerController.initialize();
    // videoPlayerController.play();
    // videoPlayerController.setVolume(1);
    // videoPlayerController.setLooping(true);
    super.initState();
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            VideoPlayer(videoPlayerController),
            Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CameraPageIcons(
                      iconString: AppCustomIcons.videoFilter,
                      onTap: () =>
                          CustomRouting.pushNamed(NamedRoutes.filter.path),
                    ),
                    const SizedBox(height: 30),
                    CameraPageIcons(
                        iconString: AppCustomIcons.videoTrim,
                        onTap: () =>
                            CustomRouting.pushNamed(NamedRoutes.trim.path)),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////
