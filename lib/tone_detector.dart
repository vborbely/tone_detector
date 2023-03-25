library tone_detector;

import 'package:flutter/material.dart';
import 'package:tone_detector/domain/controller/tone_detector_controller.dart';
import 'package:tone_detector/domain/entities/tone_analysis.dart';

class ToneDetectorWidget extends StatefulWidget {
  final ToneDetectorController controller;

  const ToneDetectorWidget({Key? key, required this.controller}) : super(key: key);

  @override
  State<ToneDetectorWidget> createState() => _ToneDetectorWidgetState();
}

class _ToneDetectorWidgetState extends State<ToneDetectorWidget> {
  // @override
  // void initState() {
  //   super.initState();
  //
  //   widget.controller.stream.addListener(() {
  //     if (widget.controller.state == ToneDetectorState.success) {
  //       _toneAnalysis = widget.controller.toneAnalysis;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: widget.controller.stream,
        builder: (context, value, child) {

          if (value == ToneDetectorState.success) {
            final aggressive = (widget.controller.toneAnalysis?.aggressive ?? 0.0) > 0.5;

            return Container(
              width: 100,
              height: 40,
              color: aggressive ? Colors.red.shade300 : Colors.greenAccent,
              child: aggressive ? const Center(child: Text("Aggressive")) : const Text("Not Aggressive"),
            );
          } else if (value == ToneDetectorState.loading) {
            return const CircularProgressIndicator();
          } else if (value == ToneDetectorState.error) {
            return const Text("Error");
          } else {
            return const Text("Initial");
          }
        });
  }
}
