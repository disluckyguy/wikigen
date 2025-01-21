
import 'package:database/database.dart';
import 'package:database/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class DatabaseClient {
  
  late final Store store;
  
  DatabaseClient._create(this.store) {
    // Add any additional setup code, e.g. build queries.
    wikiBox = store.box<WikiModel>();
  }

  late Box wikiBox;

  /// Create an instance of DatabaseClient to use throughout the app.
  static Future<DatabaseClient> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated DatabaseClient.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "wiki-db"));

    return DatabaseClient._create(store);
  }
}