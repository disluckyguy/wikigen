import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart';

const apiKey = "";

class GeminiRequestFailure implements Exception {}

class GeminiApiClient {
  Future<GenerateContentResponse> requestPrompt(
      String prompt, double temperature, String? Instructions) async {
    final generationConfig = GenerationConfig(temperature: temperature);
    final model = GenerativeModel(
      model: "gemini-1.5-flash-latest",
      apiKey: apiKey,
      systemInstruction: Content.text(Instructions ?? ""),
    );
    final content = [Content.text(prompt)];
    final response = model.generateContent(content);
    return response;
  }
}
