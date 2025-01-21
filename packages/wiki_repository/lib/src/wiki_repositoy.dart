import 'package:database/database.dart';
import 'package:gemini_api/gemini_api.dart';
import 'package:wiki_repository/src/models/wiki.dart';

class WikiRepositoy {
  WikiRepositoy(
      {GeminiApiClient? geminiApiClient,
      required DatabaseClient databaseClient})
      : _geminiApiClient = geminiApiClient ??
            GeminiApiClient(0,
                "Generate a very long and extremely detailed wiki style page for the input, avoid bullet lists and use headings instead when possible, and make each section as detailed as possible, use '#' for the title and '##' for each section heading"),
        _databaseClient = databaseClient;

  final GeminiApiClient _geminiApiClient;
  final DatabaseClient _databaseClient;

  Future<Wiki> requestWiki(String topic) async {
    final response = await _geminiApiClient.requestPrompt(topic);

    var sections = List<Section>.empty(growable: true);
    var title = "";
    var summary = "";
    var introduction = "";
    final text = response.text ?? "";
    var lines = text.split("\n");
    lines.removeWhere((item) => item.replaceAll(' ', '').isEmpty);

    for (var i = 0; i < lines.length; i += 1) {
      final line = lines[i];
      if (i == 1) {
        introduction = lines[1].replaceFirst("**introduction**", '');
      } else if (i == 0) {
        final split = line.split(":");
        title = split.first.replaceAll("#", '').replaceFirst(' ', '');
        summary = split.elementAt(1).replaceFirst(' ', '');
      } else if (line.startsWith("#")) {
        sections.add(Section(line.replaceAll("#", ''), ""));
      } else {
        sections.last = Section(
            sections.last.title, "${sections.last.contents} \n${lines[i]}");
      }
    }

    return Wiki(
        0, title, summary, introduction, sections, DateTime.now(), DateTime.now());
  }

  Future<void> saveWiki(Wiki wiki, int id) async {
    List<String> titles = List.empty(growable: true);
    List<String> contents = List.empty(growable: true);
    for (var element in wiki.sections) {
      titles.add(element.title);
    }

    for (var element in wiki.sections) {
      contents.add(element.contents);
    }

    final model = WikiModel(id, wiki.title, wiki.summary, wiki.introduction,
        titles, contents, wiki.createdOn, wiki.lastModified);

    await _databaseClient.wikiBox.putAsync(model);
  }

  Future<void> removeWiki(int id) async {
    await _databaseClient.wikiBox.removeAsync(id);
  }

  Future<void> removeLast() async {
    final models = await _databaseClient.wikiBox.getAllAsync();
    await _databaseClient.wikiBox.removeAsync(models.last.id);
  }

  Future<Wiki> getWiki(int id) async {
    final WikiModel wikiModel = await _databaseClient.wikiBox.getAsync(id);

    List<Section> sections = List.empty(growable: true);

    for (var i = 0; i < wikiModel.sectionsContents.length; i++) {
      sections.add(
          Section(wikiModel.sectionsTitles[i], wikiModel.sectionsContents[i]));
    }

    return Wiki(id, wikiModel.title, wikiModel.summary, wikiModel.introduction,
        sections, wikiModel.createdOn, wikiModel.lastModified);
  }

  Future<List<Wiki>> allWikis() async {
    final List wikiModels = await _databaseClient.wikiBox.getAllAsync();

    List<Wiki> wikis = List.empty(growable: true);
    for (var wikiModel in wikiModels) {
      List<Section> sections = List.empty(growable: true);

      for (var i = 0; i < wikiModel.sectionsContents.length; i++) {
        sections.add(Section(
            wikiModel.sectionsTitles[i], wikiModel.sectionsContents[i]));
      }

      wikis.add(Wiki(wikiModel.id, wikiModel.title, wikiModel.summary, wikiModel.introduction,
          sections, wikiModel.createdOn, wikiModel.lastModified));


      print(wikiModel.id);
    }

    return wikis;
  }
}
