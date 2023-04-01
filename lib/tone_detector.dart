library tone_detector;

import 'package:flutter/material.dart';
import 'package:tone_detector/domain/controller/tone_detector_controller.dart';

import 'presentation/widgets/bar_meter.dart';

const _kBarMeterMaxRate = 5;

/// [ToneDetectorWidget] is a widget that displays the tone analysis result.
/// It uses the [ToneDetectorController] to get the result.
/// The [ToneDetectorController] can be called with a required [input] text.
/// The [aggressiveness] value can be used for offline state or development purpose.
/// The [aggressiveness] value is between 0.0 and 1.0.
class ToneDetectorWidget extends StatefulWidget {
  final ToneDetectorController controller;

  const ToneDetectorWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<ToneDetectorWidget> createState() => _ToneDetectorWidgetState();
}

class _ToneDetectorWidgetState extends State<ToneDetectorWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.controller.stream,
        builder: (context, value, child) {
          if (value == ToneDetectorState.success) {
            final aggressive =
                widget.controller.toneAnalysis?.aggressive ?? 0.0;
            final rate = aggressive.ceil() * _kBarMeterMaxRate;

            return _mainContainer(child: BarMeter(rate: rate));
          } else if (value == ToneDetectorState.loading) {
            return _loading();
          } else if (value == ToneDetectorState.error) {
            return const Text('Error happened.');
          } else {
            return _mainContainer(child: const BarMeter(rate: 0));
          }
        });
  }

  Widget _mainContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }

  Widget _loading() {
    return const CircularProgressIndicator();
  }
}
