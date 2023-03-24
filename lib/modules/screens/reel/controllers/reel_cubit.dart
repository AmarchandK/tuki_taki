import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_session.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tuki_taki/global/routing/custom_routing.dart';
import 'package:tuki_taki/global/routing/named_routes.dart';
import 'package:tuki_taki/modules/screens/reel/model/camera_state_model.dart';
import 'package:tuki_taki/modules/screens/reel/model/reel_state.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

class ReelCubit extends Cubit<ReelStateModel> {
  ReelCubit() : super(ReelStateModel());
  ///////////// Camera Functionalities //////////////////
  late CameraController cameraController;
  final List<String> layoutVideoPathList = [];
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

  void timerStateChange() {
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
      setVideo(videoPath: video.path);
    }
  }

  void _setCameraAsInitialised(bool status) {
    emit(state.copyWith(isCameraControllerInitialsed: status));
  }

  void setVideo({required String videoPath, bool? isInBaground}) {
    final File video = File(videoPath);
    log("outPut path $video");
    emit(state.copyWith(videoFile: video));
    isInBaground != null && isInBaground == true
        ? null
        : CustomRouting.replaceStackWithNamed(NamedRoutes.confirm.path);
  }

  Future<void> _timerStart() async {
    int satrt = _timerSelection();
    for (int i = satrt; i >= 0; i--) {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(timer: i));
    }
  }

  int _timerSelection() {
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
      if (state.timeOut == 30 && state.cameraStopped == false) {
        await stopVideo();
      }
    }
    emit(state.copyWith(cameraStopped: false, timeOut: 0));
  }

  Future<void> takeVideo() async {
    await _timerStart();
    emit(state.copyWith(isRecording: true));
    await cameraController.startVideoRecording();
    timeOutCalled(30);
  }

  Future<void> stopVideo() async {
    if (state.cameraStopped == false) {
      final XFile videoFile = await cameraController.stopVideoRecording();
      setVideo(videoPath: videoFile.path);
      emit(state.copyWith(
          isRecording: false,
          timeOut: 0,
          timer: 0,
          timerState: TimerState.noTimer,
          cameraStopped: true));
    }
  }

  /////////////// trim fuctions ////////////////////////
  void onChangePlaybackState(bool value) =>
      emit(state.copyWith(trimPlaying: value));
  trimStartAsign(double value) => emit(state.copyWith(trimStart: value));
  trimEndAsign(double value) => emit(state.copyWith(trimEndValue: value));

  ////////////  Filters functions //////////
  void filterAddLoading(bool load) {
    emit(state.copyWith(filterLoading: load));
  }
  ///////////// Audio Merge with audio /////////////////

  Future<String> _getTempPath() async {
    final Directory tempDirectory = await getTemporaryDirectory();
    final String outputPath = '${tempDirectory.path}/output.mp4';
    final File outputFile = File(outputPath);
    if (outputFile.existsSync()) outputFile.deleteSync();
    return outputPath;
  }

  Future<void> mergeVideoAndAudio() async {
    const String audioPathUrl =
        'https://firebasestorage.googleapis.com/v0/b/beworld-7c16c.appspot.com/o/tukitakisongs%2FTogether.mp3?alt=media&token=9e103c27-ef01-40db-a9a2-c5f59d1d15bf';
    final File audioFile = File(audioPathUrl);
    final String videoPath = state.videoFile!.path;
    emit(state.copyWith(songAddLoading: true));
    final String outputPath = await _getTempPath();
    final String command =
        '-i $videoPath -i ${audioFile.path}  -c copy -map 0:v:0 -map 1:a:0 $outputPath';
    FFmpegKit.execute(command).then((session) async {
      final ReturnCode? returnCode = await session.getReturnCode();
      if (returnCode == null) {
        log('Session was cancelled');
        return;
      } else {
        log("returnCode###############          :${returnCode.getValue()}");
        final bool value = ReturnCode.isSuccess(returnCode);
        if (value) {
          log('Session completed successfully');
          // final String compressedPath = await compressVideo(outputPath);
          setVideo(videoPath: outputPath);
          log("===============================================     SPEED COMPLETED   ====================================================");
          emit(state.copyWith(songAddLoading: false));
        } else {
          final bool isCancel = ReturnCode.isCancel(returnCode);
          emit(state.copyWith(songAddLoading: false));
          if (isCancel) {
            log('Session was cancelled');
            emit(state.copyWith(songAddLoading: false));
          } else {
            final String? output = await session.getAllLogsAsString();
            log("Session failed: output===== --------------:$output");
            emit(state.copyWith(songAddLoading: false));
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

  ////// Add 2x Speed ///////
  void increaseSpeed() async {
    final String input = state.videoFile!.path;
    final String outputPath = await _getTempPath();
    final String command = '-i $input -filter:v "setpts=0.5*PTS" $outputPath';
    FFmpegKit.execute(command).then((value) async {
      final ReturnCode? returnCode = await value.getReturnCode();
      if (returnCode != null) {
        setVideo(videoPath: outputPath, isInBaground: true);
      } else {
        log("error while speed function -========-=-=-=-=-=-=-=-=-");
      }
    });
  }

  ///////// layout recording   /////////////
  void createGrid(int i) {
    final list = List.generate(i,
        (index) => CameraStateModel(cameraRecording: false, recorded: false));
    emit(state.copyWith(cameraLaouts: list));
  }

  void startLayoutCamera(int index) async {
    List<CameraStateModel> list = [...state.cameraLaouts];
    CameraStateModel layout = list[index];
    layout = CameraStateModel(cameraRecording: true, recorded: false);
    list[index] = layout;
    emit(state.copyWith(cameraLaouts: list));
    await cameraController.startVideoRecording();
  }

  Future<void> stopLayoutVideo(index) async {
    List<CameraStateModel> list = [...state.cameraLaouts];
    CameraStateModel layout = list[index];
    try {
      final XFile xFile = await cameraController.stopVideoRecording();
      final File file = File(xFile.path);
      final VideoPlayerController playerController =
 VideoPlayerController.file(file);
      await playerController.initialize();
      layout = CameraStateModel(
          cameraRecording: false,
          recorded: true,
          cameraFile: file,
          videoPlayerController: playerController);
      list[index] = layout;
      emit(state.copyWith(cameraLaouts: list));
      cameraController.initialize();
      layoutVideoPathList.add(file.path);
    } catch (e) {
      log("error on stop videoLayout=============== $e");
    }
  }

  Future<void> onLayoutDone() async {
    try {
      final String outputPath = await _getTempPath();
      final String command =
          " -i ${layoutVideoPathList[0]} -i ${layoutVideoPathList[1]} -filter_complex hstack=inputs=2 $outputPath";
      final FFmpegSession value = await FFmpegKit.execute(command);
      final ReturnCode? returnCode = await value.getReturnCode();
      if (returnCode != null) {
        setVideo(videoPath: outputPath);
        layoutVideoPathList.clear();
      }
    } catch (e) {
      log("error while   videos -========-=-=-=-=-=-=-=-=- $e");
    }
  }
}
