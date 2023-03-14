import 'dart:io';
import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'reel_state.freezed.dart';

@JsonSerializable(createFactory: false)
@freezed
class ReelStateModel with _$ReelStateModel {
  factory ReelStateModel({
    File? videoFile,
    @Default(false) bool isLoading,
    @Default(false) bool isCameraControllerInitialsed,
    @Default(false) bool isRecording,
    @Default(0) int cameraPosition,
    @Default([]) List<CameraDescription> cameraList,
    @Default(0) double trimStart,
    @Default(15) double trimEndValue,
    @Default(false) bool trimPlaying,
    @Default(0) int timer,
    @Default(0) int timeOut,
    @Default(true) bool initialCamera,
    @Default(TimerState.noTimer)TimerState timerState ,
  @Default(false)  bool filterLoading,
   @Default(false) bool isMerged,
    @Default(false) bool isMergingFiles,
  }) = _ReelStateModel;
}

enum TimerState { noTimer, threeTimer, fiveTimer }
