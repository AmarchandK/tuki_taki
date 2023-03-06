import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/instance_manager.dart';
import 'package:tuki_taki/global/constants.dart';
import 'package:tuki_taki/modules/screens/reel/controllers/reel_cubit.dart';
import 'package:tuki_taki/modules/screens/reel/model/reel_state.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/widgets/icons.dart';

class RightBarIcons extends StatelessWidget {
  RightBarIcons({super.key});
  final ReelCubit controller = Get.find<ReelCubit>();

  void _onTimOutPress() {
    controller.timeOutCalled(15);
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
    return BlocBuilder<ReelCubit, ReelStateModel>(
      bloc: controller,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CameraPageIcons(iconString: AppCustomIcons.songAdd, onTap: () {}),
              const SizedBox(height: 30),
              CameraPageIcons(
                  iconString: iconSelection(),
                  onTap: () => controller.timerPressed()),
            ],
          ),
        );
      },
    );
  }
}
