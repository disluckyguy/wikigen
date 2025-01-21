// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_domain.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$repositoryHash() => r'512df4471b2e41d23ad446e97f509f28074d590b';

/// See also [repository].
@ProviderFor(repository)
final repositoryProvider = FutureProvider<WikiRepositoy>.internal(
  repository,
  name: r'repositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$repositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RepositoryRef = FutureProviderRef<WikiRepositoy>;
String _$databaseHash() => r'a018c454929a9833f6724b750b4339d6acb9ac37';

/// See also [database].
@ProviderFor(database)
final databaseProvider = FutureProvider<DatabaseClient>.internal(
  database,
  name: r'databaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$databaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DatabaseRef = FutureProviderRef<DatabaseClient>;
String _$wikiHash() => r'fe93f08b31a0d797503b5139dcb883743ddb9ed2';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [wiki].
@ProviderFor(wiki)
const wikiProvider = WikiFamily();

/// See also [wiki].
class WikiFamily extends Family<AsyncValue<Wiki>> {
  /// See also [wiki].
  const WikiFamily();

  /// See also [wiki].
  WikiProvider call(
    String query,
  ) {
    return WikiProvider(
      query,
    );
  }

  @override
  WikiProvider getProviderOverride(
    covariant WikiProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'wikiProvider';
}

/// See also [wiki].
class WikiProvider extends AutoDisposeFutureProvider<Wiki> {
  /// See also [wiki].
  WikiProvider(
    String query,
  ) : this._internal(
          (ref) => wiki(
            ref as WikiRef,
            query,
          ),
          from: wikiProvider,
          name: r'wikiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$wikiHash,
          dependencies: WikiFamily._dependencies,
          allTransitiveDependencies: WikiFamily._allTransitiveDependencies,
          query: query,
        );

  WikiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<Wiki> Function(WikiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: WikiProvider._internal(
        (ref) => create(ref as WikiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Wiki> createElement() {
    return _WikiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WikiProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WikiRef on AutoDisposeFutureProviderRef<Wiki> {
  /// The parameter `query` of this provider.
  String get query;
}

class _WikiProviderElement extends AutoDisposeFutureProviderElement<Wiki>
    with WikiRef {
  _WikiProviderElement(super.provider);

  @override
  String get query => (origin as WikiProvider).query;
}

String _$localWikiHash() => r'0a6dcc2aef12dcd34cdf8760b7863a615b14170f';

/// See also [localWiki].
@ProviderFor(localWiki)
const localWikiProvider = LocalWikiFamily();

/// See also [localWiki].
class LocalWikiFamily extends Family<AsyncValue<Wiki>> {
  /// See also [localWiki].
  const LocalWikiFamily();

  /// See also [localWiki].
  LocalWikiProvider call(
    int index,
  ) {
    return LocalWikiProvider(
      index,
    );
  }

  @override
  LocalWikiProvider getProviderOverride(
    covariant LocalWikiProvider provider,
  ) {
    return call(
      provider.index,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'localWikiProvider';
}

/// See also [localWiki].
class LocalWikiProvider extends AutoDisposeFutureProvider<Wiki> {
  /// See also [localWiki].
  LocalWikiProvider(
    int index,
  ) : this._internal(
          (ref) => localWiki(
            ref as LocalWikiRef,
            index,
          ),
          from: localWikiProvider,
          name: r'localWikiProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$localWikiHash,
          dependencies: LocalWikiFamily._dependencies,
          allTransitiveDependencies: LocalWikiFamily._allTransitiveDependencies,
          index: index,
        );

  LocalWikiProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.index,
  }) : super.internal();

  final int index;

  @override
  Override overrideWith(
    FutureOr<Wiki> Function(LocalWikiRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LocalWikiProvider._internal(
        (ref) => create(ref as LocalWikiRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        index: index,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Wiki> createElement() {
    return _LocalWikiProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LocalWikiProvider && other.index == index;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, index.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LocalWikiRef on AutoDisposeFutureProviderRef<Wiki> {
  /// The parameter `index` of this provider.
  int get index;
}

class _LocalWikiProviderElement extends AutoDisposeFutureProviderElement<Wiki>
    with LocalWikiRef {
  _LocalWikiProviderElement(super.provider);

  @override
  int get index => (origin as LocalWikiProvider).index;
}

String _$wikisControllerHash() => r'f715b76946bd9ca3c2a281e6d6b2d052d0c900ba';

/// See also [WikisController].
@ProviderFor(WikisController)
final wikisControllerProvider =
    AutoDisposeAsyncNotifierProvider<WikisController, List<Wiki>>.internal(
  WikisController.new,
  name: r'wikisControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wikisControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WikisController = AutoDisposeAsyncNotifier<List<Wiki>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
