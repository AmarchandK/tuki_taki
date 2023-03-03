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
  void dispose() {
    controller.cameraController.dispose();
    super.dispose();
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height - 160,
                          child: CameraPreview(
                            controller.cameraController,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                controller.state.timer >= 0
                                    ? Align(
                                        child: Text(
                                          controller.state.timer.toString(),
                                          style: const TextStyle(
                                              fontSize: 70,
                                              color: Colors.white),
                                        ),
                                      )
                                    : const SizedBox(),
                                TopBarIcons(),
                                RightBarIcons(),
                              ],
                            ),
                          ),
                        ),
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
