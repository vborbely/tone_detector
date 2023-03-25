class ToneAnalysis {
  final String version;
  final String input;
  final double aggressive;

  ToneAnalysis({
    required this.version,
    required this.input,
    required this.aggressive,
  });

  factory ToneAnalysis.fromJson(Map<String, dynamic> json) {
    return ToneAnalysis(
      version: json['version'],
      input: json['input'],
      aggressive: json['aggressive'],
    );
  }
}

