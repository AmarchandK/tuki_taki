
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_trimmer/video_trimmer.dart';

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
