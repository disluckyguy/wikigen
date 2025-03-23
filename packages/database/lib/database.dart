import 'package:database/src/models/wiki_model.dart';
import 'package:database/src/wiki_table.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
export 'package:database/src/database_client.dart';
export 'package:database/src/models/wiki_model.dart';
part 'database.g.dart';

@DriftDatabase(tables: [WikiItems])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'app_db',
      native: const DriftNativeOptions(),
    );
  }

  Future<List<WikiItem>> get allWikis async =>
      await managers.wikiItems.get();

  Future<WikiItem> getWiki(int id) async {
    return await managers.wikiItems.filter((f) => f.id(id)).getSingle();
  }

  Future<void> saveWiki(WikiModel model) async {
    await managers.wikiItems.create((o) => o(
          title: model.title,
          introduction: model.introduction,
          summary: model.summary,
          sectionsContents: StringList(model.sectionsContents),
          sectionsTitles: StringList(model.sectionsTitles),
          createdOn: Value(model.createdOn),
          lastModified: Value(model.lastModified),
        ), mode: InsertMode.replace);
  }

  Future<void> removeWiki(int id) async {
    await managers.wikiItems.filter((f) => f.id(id)).delete();
  }
}
