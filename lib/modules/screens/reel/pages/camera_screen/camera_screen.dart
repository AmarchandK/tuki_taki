import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/instance_manager.dart';
import 'package:tuki_taki/modules/screens/reel/controllers/reel_cubit.dart';
import 'package:tuki_taki/modules/screens/reel/model/reel_state.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/capture_button.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/top_bar.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/right_bar_icons.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/tabs.dart';

class CameraReel extends StatefulWidget {
  const CameraReel({super.key});

  @override
  State<CameraReel> createState() => _CameraReelState();
}

class _CameraReelState extends State<CameraReel> {
  final ReelCubit controller = ReelCubit();
  @override
  void initState() {
    Get.put(controller, permanent: true);
    controller.startCamera(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ReelCubit, ReelStateModel>(
          bloc: controller,
          builder: (context, state) {
            return Scaffold(
              body: state.isCameraControllerInitialsed
                  ? Column(
                      children: [
                        TopBarIcons(),
                        AspectRatio(
                          aspectRatio: 3 / 4,
                          child: CameraPreview(
                            controller.cameraController,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                controller.state.timer >= 1
                                    ? Align(
                                        child: Text(
                                          controller.state.timer.toString(),
                                          style: const TextStyle(
                                              fontSize: 70,
                                              color: Colors.white),
                                        ),
                                      )
                                    : const SizedBox(),
                                RightBarIcons(),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    controller.state.timeOut > 0
                                        ? controller.state.timeOut.toString()
                                        : '',
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 25),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            SizedBox(
                              width: 140,
                              child: DefaultTabController(
                                length: 2,
                                child: TabBar(
                                  indicatorColor: Colors.transparent,
                                  tabs: [
                                    TukiTakiTabs(name: 'POST'),
                                    TukiTakiTabs(name: 'REEL')
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ButtonBarIcons(),
                        const SizedBox(height: 10)
                      ],
                    )
                  : const Center(child: CupertinoActivityIndicator()),
            );
          }),
    );
  }
}
