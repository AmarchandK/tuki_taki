import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/instance_manager.dart';
import 'package:tapioca/tapioca.dart';
import 'package:tuki_taki/modules/screens/reel/controllers/reel_cubit.dart';
import 'package:tuki_taki/modules/screens/reel/model/reel_state.dart';
import 'package:video_player/video_player.dart';

class VideoFilterScreen extends StatefulWidget {
  const VideoFilterScreen({super.key});

  @override
  State<VideoFilterScreen> createState() => _VideoFilterScreenState();
}

class _VideoFilterScreenState extends State<VideoFilterScreen> {
  final ReelCubit controller = Get.find<ReelCubit>();
  late final VideoPlayerController videoPlayerController;
  final List<List<TapiocaBall>> tapiocaBalls = [
    [TapiocaBall.filter(Filters.pink, 4)],
    [TapiocaBall.filter(Filters.white, 4)],
    [TapiocaBall.filter(Filters.blue, 4)],
  ];
  @override
  void initState() {
    videoPlayerController =
        VideoPlayerController.file(controller.state.videoFile!);
    videoPlayerController.initialize();
    // videoPlayerController.play();
    // videoPlayerController.setVolume(1);
    // videoPlayerController.setLooping(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          VideoPlayer(videoPlayerController),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 70,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: tapiocaBalls.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () => controller.onFilterApply(tapiocaBalls[index]),
                    child: Container(
                        color: Colors.pinkAccent, height: 50, width: 50),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
