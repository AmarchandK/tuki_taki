import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuki_taki/global/routing/custom_routing.dart';
import 'package:tuki_taki/global/routing/named_routes.dart';
import 'package:tuki_taki/modules/screens/reel/model/reel_state.dart';

class ReelCubit extends Cubit<ReelStateModel> {
  ReelCubit() : super(ReelStateModel());

  Future<void> pickVideo() async {
    final XFile? video =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setVideo(video.path);
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
    CustomRouting.replaceStackWithNamed(NamedRoutes.confirm.path);
  }

  ///////// trim fuctions /////////////
  void onChangePlaybackState(bool value) =>
      emit(state.copyWith(trimPlaying: value));

  trimStartAsign(double value) => emit(state.copyWith(trimStart: value));

  trimEndAsign(double value) => emit(state.copyWith(trimEndValue: value));
}
