import 'dart:convert';

import 'package:tone_detector/network/dto/tone_analysis_dto.dart';
import 'package:http/http.dart' as http;
import '../domain/config/config.dart';
import '../domain/entities/tone_analysis.dart';

class Api {
  static const String BASE_URL = "https://us-central1-my-apis-567693.cloudfunctions.net/toneAnalysis";
  // static const String BASE_URL = "http://localhost:5001/my-apis/toneAnalysis";
  static String API_KEY = TD.config.apiKey ?? '';

  static Future<ToneAnalysis> fetchToneAnalysis(String query) async {
    if (query.isEmpty) {
      throw Exception("inputText is empty");
    }
    final response = await http.post(
      Uri.parse(BASE_URL),
      headers: {'Authorization': 'Bearer $API_KEY'},
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


}
