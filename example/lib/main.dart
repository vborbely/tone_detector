import 'package:flutter/material.dart';
import 'package:tone_detector/domain/config/config.dart';
import 'package:tone_detector/domain/controller/tone_detector_controller.dart';
import 'package:tone_detector/tone_detector.dart';

import '.env.dart';

void main() {
  TD.configure(apiKey: toneDetectorServiceKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tone Detector Example',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.yellow,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final ToneDetectorController controller = ToneDetectorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat :: Tone Detector'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () => controller.analyze('I am angry'), child: const Text('Analyze')),
            ToneDetectorWidget(
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}
