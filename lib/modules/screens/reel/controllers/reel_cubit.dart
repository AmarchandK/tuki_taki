import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tapioca/tapioca.dart';
import 'package:tuki_taki/global/routing/custom_routing.dart';
import 'package:tuki_taki/global/routing/named_routes.dart';
import 'package:tuki_taki/modules/screens/reel/model/reel_state.dart';
import 'package:video_compress/video_compress.dart';

class ReelCubit extends Cubit<ReelStateModel> {
  ReelCubit() : super(ReelStateModel());
////////////// Camera Functionalities //////////////////
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

  void timerPressed() {
    if (state.timerState == TimerState.noTimer) {
      emit(state.copyWith(timerState: TimerState.threeTimer));
    } else if (state.timerState == TimerState.threeTimer) {
      emit(state.copyWith(timerState: TimerState.fiveTimer));
    } else {
      emit(state.copyWith(timerState: TimerState.noTimer));
    }
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
    CustomRouting.replaceStackWithNamed(NamedRoutes.confirm.path);
  }

  Future<void> timerStart() async {
    int satrt = timerSelection();
    for (int i = satrt; i >= 0; i--) {
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

  void timeOutCalled(int timeOutValue) async {
    for (int i = 0; i <= timeOutValue; i++) {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(timeOut: i));
    }
  }

  Future<void> takeVideo() async {
    await timerStart();
    emit(state.copyWith(isRecording: true));
    await cameraController.startVideoRecording();
  }

  Future<void> stopVideo() async {
    final XFile videoFile = await cameraController.stopVideoRecording();
    emit(state.copyWith(
        isRecording: false,
        timeOut: 0,
        timer: 0,
        timerState: TimerState.noTimer));
    setVideo(videoFile.path);
  }

  ///////// trim fuctions /////////////
  void onChangePlaybackState(bool value) =>
      emit(state.copyWith(trimPlaying: value));

  trimStartAsign(double value) => emit(state.copyWith(trimStart: value));
  trimEndAsign(double value) => emit(state.copyWith(trimEndValue: value));

  ////////////  Filters functions //////////
  void filterAddLoading(bool load) {
    emit(state.copyWith(filterLoading: load));
  }

  ///////////// Audio Merge with audio /////////////////
  String audioPathUrl =
      'https://firebasestorage.googleapis.com/v0/b/beworld-7c16c.appspot.com/o/tukitakisongs%2FTogether.mp3?alt=media&token=9e103c27-ef01-40db-a9a2-c5f59d1d15bf';
  File? audioFile;
  File? outputFile;

  Future<void> mergeVideoAndAudio() async {
    audioFile = File(audioPathUrl);
    String videoPath = state.videoFile!.path;
    emit(state.copyWith(isMergingFiles: true));
    Directory tempDirectory = await getTemporaryDirectory();
    String outputPath = '${tempDirectory.path}/output.mp4';
    //clear the output file before merging
    File outputFile = File(outputPath);
    if (outputFile.existsSync()) {
      outputFile.deleteSync();
    }
    String command =
        '-i $videoPath -i ${audioFile!.path}  -c copy -map 0:v:0 -map 1:a:0 $outputPath';

    FFmpegKit.execute(command).then((session) async {
      ReturnCode? returnCode = await session.getReturnCode();
      if (returnCode == null) {
        log('Session was cancelled');
        return;
      } else {
        log("returnCode###############          :${returnCode.getValue()}");
        bool value = ReturnCode.isSuccess(returnCode);
        if (value) {
          log('Session completed successfully');
          // final String compressedPath = await compressVideo(outputPath);
          setVideo(outputPath);
          emit(state.copyWith(isMergingFiles: false, isMerged: true));
        } else {
          bool isCancel = ReturnCode.isCancel(returnCode);
          emit(state.copyWith(isMergingFiles: false));
          if (isCancel) {
            // Session was cancelled
            log('Session was cancelled');
            emit(
              state.copyWith(isMergingFiles: false),
            );
          } else {
            // Session failed
            log('Session failed');
            //log session output
            String? output = await session.getAllLogsAsString();
            log("output--------------:$output");
            emit(state.copyWith(isMergingFiles: false));
          }
        }
      }
    });
  }

  /////////////// video compress //////////////////////
  Future<String> compressVideo(String path) async {
    MediaInfo? mediaInfo = await VideoCompress.compressVideo(path,
        quality: VideoQuality.LowQuality,
        startTime: 0,
        duration: 30,
        includeAudio: true);
    log("compressed");
    return mediaInfo!.path!;
  }
}
