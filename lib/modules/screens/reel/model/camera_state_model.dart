import 'dart:io';

import 'package:video_player/video_player.dart';

class CameraStateModel {
  final File? cameraFile;
  final VideoPlayerController? videoPlayerController;
  bool cameraRecording = false;
  bool recorded = false;
  CameraStateModel(
      {required this.cameraRecording,
      required this.recorded,
      this.cameraFile,
      this.videoPlayerController});
}
