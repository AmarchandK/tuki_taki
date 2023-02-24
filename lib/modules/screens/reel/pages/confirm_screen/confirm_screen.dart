import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tuki_taki/global/routing/custom_routing.dart';
import 'package:video_player/video_player.dart';
import 'package:video_trimmer/video_trimmer.dart';

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

class VideoTrim extends StatefulWidget {
  const VideoTrim({super.key, this.videoPath});
  final File? videoPath;
  @override
  State<VideoTrim> createState() => _VideoTrimState();
}

class _VideoTrimState extends State<VideoTrim> {
  @override
  void initState() {
    loadVideo();
    super.initState();
  }

  final Trimmer trimmer = Trimmer();
  double startValue = 0.0;
  double endValue = 15.0;
  bool isPlaying = false;
  bool progressVisibileity = false;
  loadVideo() {
    trimmer.loadVideo(videoFile: widget.videoPath!);
  }

  saveVideo() async {
    setState(() {
      progressVisibileity = true;
    });
    String? resultVideo;
    await trimmer.saveTrimmedVideo(
      startValue: startValue,
      endValue: endValue,
      onSave: (outputPath) {
        setState(() {
          progressVisibileity = false;
        });
        resultVideo = outputPath;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Visibility(
              visible: progressVisibileity,
              child: const LinearProgressIndicator(),
            ),
            ElevatedButton(
                onPressed: progressVisibileity ? null : () async => saveVideo(),
                child: const Text('Save')),
            Expanded(child: VideoViewer(trimmer: trimmer)),
            Center(
              child: TrimViewer(
                trimmer: trimmer,
                viewerHeight: 50.0,
                viewerWidth: MediaQuery.of(context).size.width,
                maxVideoLength: const Duration(seconds: 60),
                onChangeStart: (value) => startValue = value,
                onChangeEnd: (value) => endValue = value,
                onChangePlaybackState: (value) =>
                    setState(() => isPlaying = value),
              ),
            ),
            TextButton(
                onPressed: () async {
                  bool playBackState = await trimmer.videoPlaybackControl(
                      startValue: startValue, endValue: endValue);
                  isPlaying = playBackState;
                },
                child: isPlaying
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow))
          ],
        ),
      ),
    );
  }
}
