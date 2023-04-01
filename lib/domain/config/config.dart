ToneDetectorConfig? _config;

/// ToneDetectorConfig is a singleton class that holds the configuration for the ToneDetector.
/// The [apiKey] is required for the ToneDetector to work.
class ToneDetectorConfig {
  final String apiKey;

  ToneDetectorConfig({required this.apiKey});
}

abstract class TD {
  /// Call the configure function before using the ToneDetector at the beginning of your app.
  /// Eg. in the main function.
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
