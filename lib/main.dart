import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:tuki_taki/global/routing/named_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
    Get.put(globalKey);
    return GetMaterialApp(
      navigatorKey: globalKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      getPages: allRoutes,
    );
  }
}
