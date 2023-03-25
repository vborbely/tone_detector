import 'package:flutter/foundation.dart';

import '../../network/api.dart';
import '../entities/tone_analysis.dart';

enum ToneDetectorState {
  initial,
  requested,
  loading,
  error,
  success,
}

class ToneDetectorController {

  ToneDetectorState _state = ToneDetectorState.initial;

  ToneDetectorState get state => _state;

  ToneAnalysis? toneAnalysis;

  ValueNotifier<ToneDetectorState> stream = ValueNotifier(ToneDetectorState.initial);

  Future<void> analyze(String inputText) async {
    try {
      _state = ToneDetectorState.loading;
      toneAnalysis = null;
      final result = await Api.fetchToneAnalysis(inputText);
      toneAnalysis = result;
      _state = ToneDetectorState.success;
      stream.value = _state;
    } catch (e) {
      _state = ToneDetectorState.error;
      debugPrint(e.toString());
      throw Exception("Failed to retrieve tone analysis");
    }
  }

  void expand() {
    debugPrint("expand");
  }

  void collapse() {
    debugPrint("collapse");
  }

  void toggle() {
    debugPrint("toggle");
  }
}
