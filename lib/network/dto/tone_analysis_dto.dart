import '../../domain/entities/tone_analysis.dart';

class ToneAnalysisDto {
  final String version;
  final String input;
  final String aggressive;

  ToneAnalysisDto({
    required this.version,
    required this.input,
    required this.aggressive,
  });

  factory ToneAnalysisDto.fromJson(Map<String, dynamic> json) {
    return ToneAnalysisDto(
      version: json['version'],
      input: json['input'],
      aggressive: json['aggressive'],
    );
  }
}

extension TADto on ToneAnalysisDto {
  ToneAnalysis toEntity() {
    return ToneAnalysis(
      version: version,
      input: input,
      aggressive: double.tryParse(aggressive) ?? 0.0,
    );
  }
}
