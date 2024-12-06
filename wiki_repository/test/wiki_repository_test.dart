

import 'package:flutter_test/flutter_test.dart';
import 'package:wiki_repository/src/wiki_repositoy.dart';
import 'package:wiki_repository/wiki_repository.dart';

Future<void> main() async {

  final wikiRepositoy = WikiRepositoy();

      final wiki = await wikiRepositoy.get_wiki("lebron james");
    
  
  test("test response", () {
        print("${wiki.title}, ${wiki.summary}");
        wiki.sections.forEach((item) => {print("${item.title}, ")});
      });
}
