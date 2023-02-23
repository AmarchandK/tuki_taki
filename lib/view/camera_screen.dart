import 'package:flutter/material.dart';

class CameraReel extends StatefulWidget {
  const CameraReel({super.key});

  @override
  State<CameraReel> createState() => _CameraReelState();
}

class _CameraReelState extends State<CameraReel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.music_note_outlined)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.movie_filter_outlined)),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.timer_sharp)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.one_x_mobiledata_rounded)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.music_note_outlined)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 65,
        child: RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.amber,
          shape: const CircleBorder(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
