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

  void startCamera() async {
    final List<CameraDescription> cameraList = await availableCameras();
    emit(state.copyWith(cameraList: cameraList));
  }

  // void startCamera() async {
  //   final cameraList = await availableCameras();
  //   state.copyWith(cameraList: cameraList);
  //   cameraController = CameraController(cameraList[0], ResolutionPreset.medium);
  //   cameraController.initialize().then((value) {
  //     if (!mounted) {
  //       log("Camera Not Mounted");
  //       return;
  //     }
  //     setState(() {});
  //   }).catchError((error) {
  //     log(error.toString());
  //   });
  // }
}
