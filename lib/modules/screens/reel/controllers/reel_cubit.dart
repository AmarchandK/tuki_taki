import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tapioca/tapioca.dart';
import 'package:tuki_taki/global/routing/custom_routing.dart';
import 'package:tuki_taki/global/routing/named_routes.dart';
import 'package:tuki_taki/modules/screens/reel/model/reel_state.dart';

class ReelCubit extends Cubit<ReelStateModel> {
  ReelCubit() : super(ReelStateModel());
  late CameraController cameraController;

  Future<void> startCamera(int cameraPosition) async {
    _setCameraAsInitialised(false);
    final List<CameraDescription> cameraList = await availableCameras();
    emit(state.copyWith(cameraList: cameraList));
    if (state.cameraList.isNotEmpty) {
      cameraController = CameraController(
          state.cameraList[cameraPosition], ResolutionPreset.medium);
      await cameraController.initialize();
      _setCameraAsInitialised(true);
    }
  }

  Future<void> flashControle(FlashMode type) async {
    await cameraController.setFlashMode(type);
  }

  void flipCamera(int position) {
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
    final File video = File(videoPath);
    emit(state.copyWith(videoFile: video));
    log('Confirm screen go');
    CustomRouting.replaceStackWithNamed(NamedRoutes.confirm.path);
  }

  void timerPressed() {
    if (state.timerState == TimerState.noTimer) {
      emit(state.copyWith(timerState: TimerState.threeTimer));
    } else if (state.timerState == TimerState.threeTimer) {
      emit(state.copyWith(timerState: TimerState.fiveTimer));
    } else {
      emit(state.copyWith(timerState: TimerState.noTimer));
    }
  }

  Future<void> timerStart() async {
    int satrt = timerSelection();
    for (num i = satrt; i >= -1; i--) {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(timer: i));
    }
  }

  int timerSelection() {
    if (state.timerState == TimerState.threeTimer) {
      return 3;
    } else if (state.timerState == TimerState.fiveTimer) {
      return 5;
    } else {
      return 0;
    }
  }

  void timeOutCalled(num timeOutValue) async {
    for (num i = 0; i <= timeOutValue; i++) {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(timeOut: i));
    }
  }

  Future<void> takeVideo() async {
    await timerStart();
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

  //////////// add Filters //////////
  Future<void> onFilterApply(List<TapiocaBall> tapiocaBalls) async {
    log(" Filter apply");
    Directory tempDir = await getTemporaryDirectory();
    final String path = "${tempDir.path}/result.mp4";
    // final XFile xFile = XFile(state.videoFile!.path);
    final Cup cup = Cup(Content(state.videoFile!.path), tapiocaBalls);
    log("saving");
    try {
      await cup.suckUp(path);
      log("Video Setting");
      setVideo(path);
    } catch (e) {
      log('------ exteption in try  ----------- $e');
    }
  }

  void onFilterSave(String videoPath) {
    setVideo(videoPath);
  }
}
