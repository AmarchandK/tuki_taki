import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/instance_manager.dart';
import 'package:tuki_taki/modules/screens/reel/controllers/reel_cubit.dart';
import 'package:tuki_taki/modules/screens/reel/model/reel_state.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/capture_button.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/right_bar.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/right_bar_icons.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/tabs.dart';

class CameraReel extends StatefulWidget {
  const CameraReel({super.key});

  @override
  State<CameraReel> createState() => _CameraReelState();
}

class _CameraReelState extends State<CameraReel> {
  final ReelCubit reelCubit = ReelCubit();
  late final CameraController cameraController;
  @override
  void initState() {
    Get.put(reelCubit, permanent: true);
    startCamera();
    super.initState();
  }

  void startCamera() async {
    await reelCubit.getAvailableCameras();
    if (reelCubit.state.cameraList.isNotEmpty) {
      cameraController = reelCubit.switchCamera(0);
      await cameraController.initialize();
      reelCubit.setCameraAsInitialised(true);
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ReelCubit, ReelStateModel>(
          bloc: reelCubit,
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
                            cameraController,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                TopBarIcons(cameraController: cameraController),
                                const RightBarIcons(),
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
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        ButtonBarIcons(cameraController: cameraController),
                        const SizedBox(height: 10)
                      ],
                    )
                  : const Center(child: CupertinoActivityIndicator()),
            );
          }),
    );
  }
}
