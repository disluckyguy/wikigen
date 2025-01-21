import 'package:google_generative_ai/google_generative_ai.dart';

const apiKey = "AIzaSyAQWl9mNpb4BfipfU-XZF0uJRn-ue824gE";

class GeminiRequestFailure implements Exception {}

class GeminiApiClient {

  GeminiApiClient(double temperature, String? instructions) : model = GenerativeModel(
      model: "gemini-2.0-flash-exp",
      apiKey: apiKey,
      systemInstruction: Content.text(instructions ?? ""),
      generationConfig: GenerationConfig(temperature: temperature),
    );

  GenerativeModel model;
  Future<GenerateContentResponse> requestPrompt(String prompt) async {
    
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    return response;
  }


}
