import 'dart:io';
import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tuki_taki/modules/screens/reel/model/camera_state_model.dart';
part 'reel_state.freezed.dart';

@JsonSerializable(createFactory: false)
@freezed
class ReelStateModel with _$ReelStateModel {
  factory ReelStateModel({
    File? videoFile,
    @Default(false) bool isLoading,
    @Default(false) bool isCameraControllerInitialsed,
    @Default(false) bool isRecording,
    @Default(false) bool cameraStopped,
    @Default(0) int cameraPosition,
    @Default([]) List<CameraDescription> cameraList,
    @Default(0) double trimStart,
    @Default(30) double trimEndValue,
    @Default(false) bool trimPlaying,
    @Default(0) int timer,
    @Default(0) int timeOut,
    @Default(true) bool initialCamera,
    @Default(TimerState.noTimer) TimerState timerState,
    @Default(false) bool filterLoading,
    @Default(false) bool songAddLoading,
    @Default(false) bool speedLoading,
    @Default([]) List<CameraStateModel> cameraLaouts,
    @Default('1x') String speedValue,
    @Default(false) bool speedTaped,
    @Default(false) bool showAnimation,
  }) = _ReelStateModel;
}

enum TimerState { noTimer, threeTimer, fiveTimer }
