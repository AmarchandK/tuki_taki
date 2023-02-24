import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tuki_taki/global/routing/custom_routing.dart';
import 'package:tuki_taki/modules/screens/reel/pages/confirm_screen/widgets/trim.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  ConfirmScreen({super.key, this.videoPath});
  final String? videoPath;
  File? file;
  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late final VideoPlayerController videoPlayerController;
  @override
  void initState() {
    String? videoPath = widget.videoPath ?? Get.arguments["videoPath"];
    if (videoPath != null) {
      widget.file = File(videoPath.toString());
      videoPlayerController = VideoPlayerController.file(widget.file!);
      videoPlayerController.initialize();
      videoPlayerController.play();
      videoPlayerController.setVolume(1);
      videoPlayerController.setLooping(true);
    } else {
      CustomRouting.pop();
    }

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
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.filter,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.off(() => VideoTrim(
                              videoPath: widget.file,
                            ));
                      },
                      icon: const Icon(
                        Icons.cut_outlined,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        videoPlayerController.setPlaybackSpeed(2);
                      },
                      icon: const Icon(
                        Icons.speed,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

/////////////////////////////////////////////////////////
}
