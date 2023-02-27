import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuki_taki/global/routing/custom_routing.dart';
import 'package:tuki_taki/global/routing/named_routes.dart';
import 'package:tuki_taki/modules/screens/reel/model/reel_state.dart';

class ReelCubit extends Cubit<ReelStateModel> {
  ReelCubit() : super(ReelStateModel());
  late CameraController cameraController;

  Future<void> startCamera(int cameraPosition) async {
    log(cameraPosition.toString());
    _setCameraAsInitialised(false);
    final List<CameraDescription> cameraList = await availableCameras();
    emit(state.copyWith(cameraList: cameraList));
    if (state.cameraList.isNotEmpty) {
      cameraController = CameraController(
          state.cameraList[cameraPosition], ResolutionPreset.high);
      log(cameraController.description.name.toString());
      await cameraController.initialize();
      _setCameraAsInitialised(true);
    }
  }

  Future<void> flashControle(FlashMode type) async {
    await cameraController.setFlashMode(type);
  }

  flipCamera(int position) {
    startCamera(position);
    emit(state.copyWith(initialCamera: !state.initialCamera));
  }

  Future<void> pickVideo() async {
    final XFile? video =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setVideo(video.path);
    }
  }

  void _setCameraAsInitialised(bool status) {
    emit(state.copyWith(isCameraControllerInitialsed: status));
  }

  void setVideo(String videoPath) {
    log(videoPath);
    final video = File(videoPath);
    emit(state.copyWith(videoFile: video));
    CustomRouting.replaceStackWithNamed(NamedRoutes.confirm.path);
  }

  timerStart(int satrt) async {
    emit(state.copyWith(functionLoading: true));
    for (num i = satrt; i >= -1; i--) {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(timer: i));
    }
    emit(state.copyWith(functionLoading: false));
  }

  Future<void> takeVideo() async {
    await cameraController.startVideoRecording();
    emit(state.copyWith(isRecording: true));
  }

  Future<void> stopVideo() async {
    final XFile videoFile = await cameraController.stopVideoRecording();
    emit(state.copyWith(isRecording: false));
    setVideo(videoFile.path);
  }

  ///////// trim fuctions /////////////
  void onChangePlaybackState(bool value) =>
      emit(state.copyWith(trimPlaying: value));

  trimStartAsign(double value) => emit(state.copyWith(trimStart: value));
  trimEndAsign(double value) => emit(state.copyWith(trimEndValue: value));
}
