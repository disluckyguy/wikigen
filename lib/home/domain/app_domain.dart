import 'package:database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiki_repository/wiki_repository.dart';

part 'app_domain.g.dart';

@Riverpod(keepAlive: true)
Future<WikiRepositoy> repository(Ref ref) async {
  final database = await ref.watch(databaseProvider.future);
  return WikiRepositoy(databaseClient: database);
}

@riverpod
Future<DatabaseClient> database(Ref ref) async {
  final database = DatabaseClient();
  return database;
}


@riverpod
Future<Wiki> wiki(Ref ref, String query, String apiKey) async {
  final repository =  await ref.watch(repositoryProvider.future);
  return repository.requestWiki(query, apiKey);
}

@Riverpod(keepAlive: true)
Future<SharedPreferencesAsync> preferences(Ref ref) async {
  return SharedPreferencesAsync();
}

@riverpod
Future<Wiki> localWiki(Ref ref, int index) async {
    final repository = await ref.watch(repositoryProvider.future);
    return repository.getWiki(index);
  }

@riverpod
class WikisController extends _$WikisController {
  @override
  Future<List<Wiki>> build() async {
    final repository = await ref.watch(repositoryProvider.future);
    return repository.allWikis();
  }

  Future<void> addWiki(Wiki wiki) async {
    final repository = await ref.watch(repositoryProvider.future);
    
    await repository.saveWiki(wiki, 0);
    
    ref.invalidateSelf();

    
    await future;
  }

  Future<void> removeWiki(int id) async {
    final repository = await ref.watch(repositoryProvider.future);
    
    await repository.removeWiki(id);
    
    ref.invalidateSelf();

    
    await future;
  }

  Future<void> removeLastWiki() async {
    final repository = await ref.watch(repositoryProvider.future);
    
    await repository.removeLast();

    ref.invalidateSelf();

    
    await future;
  }
}