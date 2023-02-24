import 'dart:io';
import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'reel_state.freezed.dart';

@JsonSerializable(createFactory: false)
@freezed
class ReelStateModel with _$ReelStateModel {
  factory ReelStateModel({
    File? videoFile,
    @Default([]) List<CameraDescription> cameraList,
  }) = _ReelStateModel;
}
