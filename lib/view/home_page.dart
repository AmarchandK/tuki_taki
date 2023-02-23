import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuki_taki/global/routing/custom_routing.dart';
import 'package:tuki_taki/global/routing/named_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.gallery, context),
                  child: const Text('Gallery'),
                ),
                SimpleDialogOption(
                  onPressed: () => pickVideo(ImageSource.camera, context),
                  child: const Text('Camera'),
                )
              ],
            ),
          ),
          child: const Text('Take a reel'),
        ),
      ),
    );
  }

  Future<void> pickVideo(ImageSource source, BuildContext context) async {
    final XFile? video = await ImagePicker().pickVideo(
      source: source,
      maxDuration: const Duration(seconds: 15),
    );
    final File? pickedVideo;
    if (video != null) {
      pickedVideo = File(video.path);
      CustomRouting.pop();
      CustomRouting.pushNamed(NamedRoutes.confirm.path,
          arguments: {"videoPath": pickedVideo.path});
    }
  }
}
