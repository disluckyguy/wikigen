import 'package:gemini_api/gemini_api.dart';
import 'package:wiki_repository/src/models/wiki.dart';

class WikiRepositoy {
  WikiRepositoy({GeminiApiClient? geminiApiClient})
      : _geminiApiClient = geminiApiClient ?? GeminiApiClient();

  final GeminiApiClient _geminiApiClient;

  Future<Wiki> get_wiki(String topic) async {
    final response = await _geminiApiClient.requestPrompt(topic, 0,
        "Generate a very long and extremely detailed wiki style page for the input, avoid bullet lists and use headings instead when possible, and make the page as detailed as possible, don't use conclusions or bullet lists");

    var sections = List<Section>.empty(growable: true);
    var title = "";
    var summary = "";
    var introduction = "";
    final text = response.text ?? "";
    var lines = text.split("\n");
    lines.removeWhere((item) => item.replaceAll(' ', '').isEmpty);

    print(text);

    for (var i = 0; i < lines.length; i += 1) {
      final line = lines[i];
      if (i == 1) {
        introduction = lines[1].replaceFirst("**introduction**", '');
      } else if (i == 0) {
        final split = line.split(":");
        title = split.first.replaceAll("#", '').replaceFirst(' ', '');
        summary = split.elementAt(1).replaceFirst(' ', '');
      } else if (line.startsWith("#")) {
        sections.add(
            Section(line.replaceAll("## ", '').replaceAll("### ", ''), ""));
      } else {
        sections.last = Section(
            sections.last.title, "${sections.last.contents} \n${lines[i]}");
      }
    }

    return Wiki(
        title, summary, introduction, sections, DateTime.now(), DateTime.now());
  }
}
