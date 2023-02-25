import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:camera/src/camera_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuki_taki/global/routing/custom_routing.dart';
import 'package:tuki_taki/global/routing/named_routes.dart';
import 'package:tuki_taki/modules/screens/reel/model/reel_state.dart';

class ReelCubit extends Cubit<ReelStateModel> {
  ReelCubit() : super(ReelStateModel());
  late CameraController cameraController;

  Future<void> startCamera(int cameraPosition) async {
    await getAvailableCameras();
    if (state.cameraList.isNotEmpty) {
      log('------------');
      cameraController = switchCamera(cameraPosition);
      await cameraController.initialize();
      _setCameraAsInitialised(true);
    }
  }

  Future<void> pickVideo() async {
    final XFile? video =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setVideo(video.path);
    }
  }

  Future<void> getAvailableCameras() async {
    final cameraList = await availableCameras();
    emit(state.copyWith(cameraList: cameraList));
  }

  CameraController switchCamera(int i) =>
      CameraController(state.cameraList[i], ResolutionPreset.medium);

  void _setCameraAsInitialised(bool status) {
    emit(state.copyWith(isCameraControllerInitialsed: status));
  }

  void setRecordingAs(bool record) {
    emit(state.copyWith(isRecording: record));
  }

  void setVideo(String videoPath) {
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

  ///////// trim fuctions /////////////
  void onChangePlaybackState(bool value) =>
      emit(state.copyWith(trimPlaying: value));

  trimStartAsign(double value) => emit(state.copyWith(trimStart: value));

  trimEndAsign(double value) => emit(state.copyWith(trimEndValue: value));
}
