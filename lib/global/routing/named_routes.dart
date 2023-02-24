import 'package:get/route_manager.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/camera_screen.dart';
import 'package:tuki_taki/modules/screens/reel/pages/confirm_screen/confirm_screen.dart';
import 'package:tuki_taki/modules/screens/reel/pages/trim_screen/trim_screen.dart';

enum NamedRoutes { reel, confirm, trim }

extension NamedRoutesData on NamedRoutes {
  String get path {
    switch (this) {
      case NamedRoutes.reel:
        return '/';
      case NamedRoutes.confirm:
        return '/confirm';
      case NamedRoutes.trim:
        return '/trim';
      default:
        return '/reel';
    }
  }
}

List<GetPage> allRoutes = [
  GetPage(name: NamedRoutes.reel.path, page: () => const CameraReel()),
  GetPage(name: NamedRoutes.confirm.path, page: () => const ConfirmScreen()),
  GetPage(name: NamedRoutes.trim.path, page: () => const TrimVedoPage())
];
