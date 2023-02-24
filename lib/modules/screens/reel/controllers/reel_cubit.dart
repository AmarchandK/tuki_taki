import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuki_taki/modules/screens/reel/model/reel_state.dart';

class ReelCubit extends Cubit<ReelStateModel> {
  ReelCubit() : super(ReelStateModel());

  Future<void> pickVideo() async {
    final XFile? video =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video != null) {
      File pickedVideo = File(video.path);
      emit(state.copyWith(videoFile: pickedVideo));
    }
  }

  void setCameraAsInitialised() {
    emit(state.copyWith(isCameraControllerInitialsed: true));
  }

  void setRecordingAs(bool record) {
    emit(state.copyWith(isRecording: record));
  }

  void setVideo(String videoPath) {
    final video = File(videoPath);
    emit(state.copyWith(videoFile: video));
  }
}
