import 'package:flutter/material.dart';
import 'package:tone_detector/domain/config/config.dart';
import 'package:tone_detector/domain/controller/tone_detector_controller.dart';
import 'package:tone_detector/tone_detector.dart';

import '.env.dart';

void main() {
  TD.configure(apiKey: toneDetectorServiceKey ?? '');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tone Detector Example',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade200,
        primarySwatch: Colors.yellow,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54, width: 2)),
          labelStyle: TextStyle(color: Colors.black54),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ToneDetectorController _controller = ToneDetectorController();

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat :: Tone Detector'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black54)),
                  labelText: 'Enter your message',
                ),
                onChanged: (value) => setState(() {}),
                controller: _textEditingController,
                maxLines: 2,
              ),
            ),
            ElevatedButton(
              onPressed: _textEditingController.text.length > 3
                  ? () => _controller.analyze(_textEditingController.text)
                  // ? () => _controller.analyze(_textEditingController.text, aggressiveness: 0.4)
                  : null,
              child: const Text('Analyze'),
            ),
            const SizedBox(height: 20),
            ToneDetectorWidget(
              controller: _controller,
            ),
          ],
        ),
      ),
    );
  }
}
