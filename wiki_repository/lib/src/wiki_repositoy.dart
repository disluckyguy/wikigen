

import 'package:gemini_api/gemini_api.dart';
import 'package:wiki_repository/models/wiki.dart';

class WikiRepositoy {
  WikiRepositoy({GeminiApiClient? geminiApiClient}): _geminiApiClient = geminiApiClient ?? GeminiApiClient();

  final GeminiApiClient _geminiApiClient;

  Future<Wiki> get_wiki(String topic) async {
    final response = await _geminiApiClient.requestPrompt(topic, 0,"Generate a very long and extremely detailed wiki style page for the input, avoid bullet lists and use headings instead when possible, and make the page as detailed as possible, don't use conclusions or bullet lists");
    
    var sections = List<Section>.empty();
    var title = "";
    var summary = "";
    final text = response.text ?? "";
    var lines = text.split("\n");
    lines.removeWhere((item) => item.replaceAll(' ', '').isEmpty);

    for (var i = 0; i < lines.length; i += 1) {
      final line = lines[i];
      if (line.startsWith("## ")) {
        final split = line.split(":");
        title = split.first.replaceFirst("## ", '');
        summary = split.elementAt(1).replaceFirst(' ', '');
      }

      if (line.startsWith("### ")) {
        sections.add(Section(line.replaceFirst('### ', ''), lines[i + 1]));
      }
    }
    
    return Wiki(title, summary, sections, DateTime.now(), DateTime.now());
  }
}