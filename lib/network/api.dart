import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:tone_detector/network/dto/tone_analysis_dto.dart';

import '../domain/config/config.dart';
import '../domain/entities/tone_analysis.dart';

class Api {
  static const String baseUrl = "https://us-central1-my-apis-567693.cloudfunctions.net/toneAnalysis";

  // static const String BASE_URL = "http://localhost:5001/my-apis/toneAnalysis";
  static String apiKey = TD.config.apiKey;

  static Future<ToneAnalysis> fetchToneAnalysis(String query, {double? aggressiveness}) async {
    if (aggressiveness != null) {
      return await _generateSample(aggressiveness);
    }

    if (query.isEmpty) {
      throw Exception("inputText is empty");
    }
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'Bearer $apiKey'},
      body: {"query": query},
    );
    if (response.statusCode >= 200 && response.statusCode < 400) {
      final result = response.body;
      try {
        final dto = ToneAnalysisDto.fromJson(jsonDecode(result));
        return dto.toEntity();
      } catch (e) {
        throw Exception("Failed to retrieve tone analysis");
      }
    } else {
      throw Exception("Failed to retrieve tone analysis");
    }
  }

  static Future<ToneAnalysis> _generateSample(double aggressiveness) async {
    ToneAnalysis analysis = ToneAnalysis(
      version: "1.0.0",
      input: "This is a sample text with aggressive tone set to $aggressiveness",
      aggressive: aggressiveness,
    );
    return Future.delayed(Duration(milliseconds: Random.secure().nextInt(1000) + 500), () => analysis);
  }
}
