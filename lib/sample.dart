import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool changeVal = false;
  bool showVal = true;
  String selectedzoom = '3x';
  final List<String> zoomVal = ['3x', '.5x', '1x', '2x', '3x'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[400],
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () async {
                  setState(() {
                    changeVal = !changeVal;
                  });
                  await Future.delayed(
                      Duration(milliseconds: changeVal ? 400 : 0));
                  setState(() {
                    showVal = !showVal;
                  });
                },
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 4,
                        top: 4,
                        child: AnimatedContainer(
                          curve: Curves.easeInOutCubic,
                          duration: const Duration(milliseconds: 500),
                          height: changeVal ? 100 : 0,
                          width: changeVal ? 70 : 0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(changeVal ? 20 : 0),
                              bottomRight: Radius.circular(changeVal ? 10 : 0),
                              bottomLeft: Radius.circular(changeVal ? 10 : 0),
                              topRight: Radius.circular(changeVal ? 10 : 0),
                            ),
                            color: Colors.black.withOpacity(0.4),
                          ),
                          child: Wrap(
                            children: List.generate(
                              zoomVal.length,
                              (index) => InkWell(
                                  onTap: () async {
                                    setState(() {
                                      selectedzoom = zoomVal[index];
                                      changeVal = false;
                                    });
                                    await Future.delayed(Duration(
                                        milliseconds: changeVal ? 400 : 0));
                                    setState(() {
                                      showVal = !showVal;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      zoomVal[index],
                                      style: TextStyle(
                                        color: !showVal
                                            ? Colors.white
                                            : Colors.transparent,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: Center(
                            child: Text(
                          selectedzoom,
                          style: const TextStyle(
                            color: Colors.pink,
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
              )
            ]));
  }
}
