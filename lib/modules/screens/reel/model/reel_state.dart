import 'dart:io';
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
    @Default(0) double trimStart,
    @Default(15) double trimEndValue,
    @Default(false) bool trimPlaying,
  }) = _ReelStateModel;
}
