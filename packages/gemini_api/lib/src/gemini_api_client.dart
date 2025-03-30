import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiRequestFailure implements Exception {}

class GeminiApiClient {

  GeminiApiClient(double? temperature, String instructions): _instructions = instructions, _temperature = temperature ?? 0.7;
  final String? _instructions;
  final double _temperature;


  
  Future<GenerateContentResponse> requestPrompt(String prompt, String apiKey) async {
    GenerativeModel model = GenerativeModel(
      model: "gemini-2.0-flash",
      apiKey: apiKey,
      systemInstruction: Content.text(_instructions ?? ""),
      generationConfig: GenerationConfig(temperature: _temperature),
    );
;
    
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    return response;
  }


}
