import 'package:flutter_test/flutter_test.dart';
import 'package:tone_detector/domain/controller/tone_detector_controller.dart';

import 'package:tone_detector/tone_detector.dart';

void main() {
  test('adds one to input values', () {
    final controller = ToneDetectorController();
    ToneDetectorWidget(controller: controller);
  });
}
