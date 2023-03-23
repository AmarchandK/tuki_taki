import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/instance_manager.dart';
import 'package:path_provider/path_provider.dart';
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
  late VideoPlayerController videoPlayerController;
  final List<List<TapiocaBall>> tapiocaBalls = [
    [TapiocaBall.filter(Filters.transparent, 0.01)],
    [TapiocaBall.filter(Filters.pink, 0.2)],
    [TapiocaBall.filter(Filters.white, 0.2)],
    [TapiocaBall.filter(Filters.blue, 0.2)],
    [TapiocaBall.filter(Filters.red, 0.2)],
    [TapiocaBall.filter(Filters.orange, 0.2)],
    [TapiocaBall.filter(Filters.cyan, 0.2)],
    [TapiocaBall.filter(Filters.green, 0.2)],
    [TapiocaBall.filter(Filters.golden, 0.2)],
    [TapiocaBall.filter(Filters.brown, 0.2)],
    [TapiocaBall.filter(Filters.violet, 0.2)]
  ];
  final Map<String, Color> filters = {
    "orginal": const Color(0x00000000),
    "pink": const Color(0xffffc0cb),
    "white": const Color(0xffffffff),
    "blue": const Color(0xff1f8eed),
    "red": const Color(0xffff969f),
    "orange": const Color(0xffffd5c0),
    "cyan": const Color(0xffc0ffff),
    "green": const Color(0xffc6fac5),
    "golden": const Color(0xfffeffc0),
    "brown": const Color(0xff5c3e13),
    "violet": const Color(0xffffc0fa)
  };
  Color color = Colors.transparent;
  static const EventChannel _channel = EventChannel('video_editor_progress');
  late StreamSubscription _streamSubscription;
  int processPercentage = 0;
  int filterIndex = 0;
  @override
  void initState() {
    videoInitialize();
    _enableEventReceiver();
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  Future<void> videoInitialize() async {
    videoPlayerController =
        VideoPlayerController.file(controller.state.videoFile!);
    videoPlayerController.initialize();
    // videoPlayerController.play();
    // videoPlayerController.setVolume(1);
    // videoPlayerController.setLooping(true);
  }

  void onFilterApply(int index) {
    controller.filterAddLoading(true);
    filterIndex = index;
    color = filters.values.toList()[index].withOpacity(0.2);
    controller.filterAddLoading(false);
  }

  void _enableEventReceiver() {
    _streamSubscription =
        _channel.receiveBroadcastStream().listen((dynamic event) {
      setState(() {
        processPercentage = (event.toDouble() * 100).round();
      });
    }, onError: (dynamic error) {
      log('Received error: ${error.message}');
    }, cancelOnError: true);
  }

  Future<void> filterDone() async {
    controller.filterAddLoading(true);
    final Directory tempDir = await getTemporaryDirectory();
    final String path =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}result.mp4';
    final Cup cup = Cup(
        Content(controller.state.videoFile!.path), tapiocaBalls[filterIndex]);
    await cup.suckUp(path);
    setState(() => processPercentage = 0);
    controller.setVideo(videoPath: path);
    controller.filterAddLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ReelCubit, ReelStateModel>(
        bloc: controller,
        builder: (context, state) {
          return SafeArea(
            child: state.filterLoading
                ? Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 10),
                      Text(
                        "$processPercentage%",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ]),
                  )
                : Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                            onPressed: () => filterDone(),
                            child: const Text('Done')),
                      ),
                      Center(
                        child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Stack(
                            children: [
                              VideoPlayer(videoPlayerController),
                              Container(color: color)
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black.withOpacity(.8)),
                          height: 90,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: tapiocaBalls.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => onFilterApply(index),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor:
                                            filters.values.toList()[index],
                                        radius: 25),
                                    const SizedBox(height: 5),
                                    Text(
                                      filters.keys
                                          .toList()[index]
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          );
        },
      ),
    );
  }
}
