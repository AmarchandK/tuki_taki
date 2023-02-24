import 'package:get/route_manager.dart';
import 'package:tuki_taki/modules/screens/home_page.dart';

enum NamedRoutes { home, confirm }

extension NamedRoutesData on NamedRoutes {
  String get path {
    switch (this) {
      case NamedRoutes.home:
        return '/';
      case NamedRoutes.confirm:
        return '/confirm';
      default:
        return '/home';
    }
  }
}

List<GetPage> allRoutes = [
  GetPage(name: NamedRoutes.home.path, page: () => const HomePage()),
  // GetPage(name: NamedRoutes.confirm.path, page: () => ConfirmScreen())
];
