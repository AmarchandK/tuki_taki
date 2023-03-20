import 'dart:io';

class CameraStateModel {
  File? cameraFile;
  bool cameraRecording = false;
  bool recorded = false;
  CameraStateModel({this.cameraFile, required this.cameraRecording, required this.recorded});
}
