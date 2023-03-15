import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/instance_manager.dart';
import 'package:tuki_taki/global/constants.dart';
import 'package:tuki_taki/modules/screens/reel/controllers/reel_cubit.dart';
import 'package:tuki_taki/modules/screens/reel/model/reel_state.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/icons.dart';

class TopBarIcons extends StatelessWidget {
  TopBarIcons({super.key});

  final ReelCubit controller = Get.find<ReelCubit>();
  bool flashOn = false;

  void selectFlash() async {
    flashOn = !flashOn;
    await controller.flashControle(flashOn ? FlashMode.torch : FlashMode.off);
  }

  void _onTimOutPress() {
    controller.timeOutCalled(30);
  }

  String iconSelection() {
    return controller.state.timerState == TimerState.noTimer
        ? AppCustomIcons.timer
        : controller.state.timerState == TimerState.threeTimer
            ? AppCustomIcons.timer3s
            : AppCustomIcons.timer5s;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: BlocBuilder<ReelCubit, ReelStateModel>(
        bloc: controller,
        builder: (context, state) {
          return Container(
            color: Colors.black,
            child: Row(
              children: [
                const SizedBox(width: 10),
                CameraPageIcons(
                    iconString: AppCustomIcons.flashOn, onTap: selectFlash),
                const Spacer(),
                CameraPageIcons(
                    iconString: iconSelection(),
                    onTap: () => controller.timerPressed()),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
