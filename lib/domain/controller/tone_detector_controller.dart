import 'package:flutter/foundation.dart';
import 'package:tone_detector/domain/config/config.dart';

import '../../network/api.dart';
import '../entities/tone_analysis.dart';

enum ToneDetectorState {
  initial,
  requested,
  loading,
  error,
  success,
}

/// The [ToneDetectorController] can be utilized with the `analyze` function.
/// The [analyze] function has a required [inputText] field. The [aggresiveness] field is optional.
/// The [aggressiveness] value can be used for offline state or development purpose.
/// The [aggressiveness] value is between 0.0 and 1.0.
/// If no ApiKey and no [aggressiveness] value is provided, the default value is 0.5.
class ToneDetectorController {
  ToneDetectorState _state = ToneDetectorState.initial;

  ToneDetectorState get state => _state;

  set state(ToneDetectorState state) {
    _state = state;
    stream.value = state;
  }

  ToneAnalysis? toneAnalysis;

  ValueNotifier<ToneDetectorState> stream = ValueNotifier(ToneDetectorState.initial);
  ValueNotifier<bool> expanded = ValueNotifier(false);

  Future<void> analyze(String inputText, {double? aggressiveness}) async {
    final config = TD.config;
    double? aggr = (aggressiveness == null && config.apiKey.isEmpty) ? 0.5 : aggressiveness;
    aggr = (aggr ?? 0.0) > 1.0 ? 1.0 : aggr;
    aggr = (aggr ?? 0.0) < 0.0 ? 0.0 : aggr;

    try {
      state = ToneDetectorState.loading;
      toneAnalysis = null;
      final result = await Api.fetchToneAnalysis(inputText, aggressiveness: aggr);
      toneAnalysis = result;
      state = ToneDetectorState.success;
    } catch (e) {
      state = ToneDetectorState.error;
      debugPrint(e.toString());
      throw Exception("Failed to retrieve tone analysis");
    }
  }

  void expand() {
    expanded.value = true;
  }

  void collapse() {
    expanded.value = false;
  }

  void toggle() {
    expanded.value = !expanded.value;
  }
}
