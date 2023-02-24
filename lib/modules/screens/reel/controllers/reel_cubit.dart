import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuki_taki/global/routing/custom_routing.dart';
import 'package:tuki_taki/global/routing/named_routes.dart';
import 'package:tuki_taki/modules/screens/reel/model/reel_state.dart';
import 'package:tuki_taki/modules/screens/reel/pages/confirm_screen/confirm_screen.dart';

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
    CustomRouting.pushNamed(NamedRoutes.confirm.path);
  }
}
