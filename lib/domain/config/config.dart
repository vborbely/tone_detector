ToneDetectorConfig? _config;

class ToneDetectorConfig {
  final String apiKey;

  ToneDetectorConfig({required this.apiKey});
}

abstract class TD {
  static void configure({required String apiKey}) {
    _config = ToneDetectorConfig(apiKey: apiKey);
  }

  static ToneDetectorConfig get config {
    if (_config == null) {
      throw Exception("ToneDetector is not configured");
    }
    return _config!;
  }
}
