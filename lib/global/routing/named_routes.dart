import 'package:get/route_manager.dart';
import 'package:tuki_taki/modules/screens/reel/pages/camera_screen/camera_screen.dart';
import 'package:tuki_taki/modules/screens/reel/pages/confirm_screen/confirm_screen.dart';
import 'package:tuki_taki/modules/screens/reel/pages/trim_screen/trim_screen.dart';
import 'package:tuki_taki/modules/screens/reel/pages/video_filter_screen/video_filter_screen.dart';
import 'package:tuki_taki/modules/screens/reel/pages/video_layout/layout_screen.dart';

enum NamedRoutes { reel, confirm, trim, filter, layout }

extension NamedRoutesData on NamedRoutes {
  String get path {
    switch (this) {
      case NamedRoutes.confirm:
        return '/';
      case NamedRoutes.reel:
        return '/reel';
      case NamedRoutes.trim:
        return '/trim';
      case NamedRoutes.filter:
        return '/filter';
      case NamedRoutes.layout:
        return '/layout';
      default:
        return '/confirm';
    }
  }
}

List<GetPage> allRoutes = [
  GetPage(name: NamedRoutes.reel.path, page: () => const CameraReel()),
  GetPage(name: NamedRoutes.confirm.path, page: () => const ConfirmScreen()),
  GetPage(name: NamedRoutes.trim.path, page: () => const TrimVedoPage()),
  GetPage(name: NamedRoutes.filter.path, page: () => const VideoFilterScreen()),
  GetPage(name: NamedRoutes.layout.path, page: () => const LayoutCamera())
];
