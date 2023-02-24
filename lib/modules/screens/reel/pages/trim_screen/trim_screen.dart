import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/instance_manager.dart';
import 'package:tuki_taki/modules/screens/reel/controllers/reel_cubit.dart';
import 'package:tuki_taki/modules/screens/reel/model/reel_state.dart';
import 'package:video_trimmer/video_trimmer.dart';

class TrimVedoPage extends StatefulWidget {
  const TrimVedoPage({super.key});
  @override
  State<TrimVedoPage> createState() => _TrimVedoPageState();
}

class _TrimVedoPageState extends State<TrimVedoPage> {
  final ReelCubit controller = Get.find<ReelCubit>();
  final Trimmer trimmer = Trimmer();

  @override
  void initState() {
    loadVideo();
    super.initState();
  }

  void loadVideo() {
    trimmer.loadVideo(videoFile: controller.state.videoFile!);
  }

  void saveVideo() async {
    await trimmer.saveTrimmedVideo(
        startValue: controller.state.trimStart,
        endValue: controller.state.trimStart,
        onSave: (outputPath) => controller.setVideo(outputPath!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ReelCubit, ReelStateModel>(
            bloc: controller,
            builder: (context, state) {
              return Column(
                children: [
                  ElevatedButton(
                      onPressed: () => saveVideo(), child: const Text('Save')),
                  Expanded(child: VideoViewer(trimmer: trimmer)),
                  Center(
                    child: TrimViewer(
                      trimmer: trimmer,
                      viewerHeight: 50.0,
                      viewerWidth: MediaQuery.of(context).size.width,
                      maxVideoLength: const Duration(seconds: 60),
                      onChangeStart: (value) =>
                          controller.trimStartAsign(value),
                      onChangeEnd: (value) => controller.trimEndAsign(value),
                      onChangePlaybackState: (value) =>
                          controller.onChangePlaybackState(value),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        bool playBackState = await trimmer.videoPlaybackControl(
                            startValue: controller.state.trimStart,
                            endValue: controller.state.trimEndValue);
                        controller.onChangePlaybackState(playBackState);
                      },
                      child: controller.state.trimPlaying
                          ? const Icon(Icons.pause)
                          : const Icon(Icons.play_arrow))
                ],
              );
            }),
      ),
    );
  }
}
