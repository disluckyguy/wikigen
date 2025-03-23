// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $WikiItemsTable extends WikiItems
    with TableInfo<$WikiItemsTable, WikiItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WikiItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _summaryMeta =
      const VerificationMeta('summary');
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
      'summary', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _introductionMeta =
      const VerificationMeta('introduction');
  @override
  late final GeneratedColumn<String> introduction = GeneratedColumn<String>(
      'introduction', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<StringList, String>
      sectionsTitles = GeneratedColumn<String>(
              'sections_titles', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<StringList>($WikiItemsTable.$convertersectionsTitles);
  @override
  late final GeneratedColumnWithTypeConverter<StringList, String>
      sectionsContents = GeneratedColumn<String>(
              'sections_contents', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<StringList>(
              $WikiItemsTable.$convertersectionsContents);
  static const VerificationMeta _createdOnMeta =
      const VerificationMeta('createdOn');
  @override
  late final GeneratedColumn<DateTime> createdOn = GeneratedColumn<DateTime>(
      'created_on', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _lastModifiedMeta =
      const VerificationMeta('lastModified');
  @override
  late final GeneratedColumn<DateTime> lastModified = GeneratedColumn<DateTime>(
      'last_modified', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        summary,
        introduction,
        sectionsTitles,
        sectionsContents,
        createdOn,
        lastModified
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wiki_items';
  @override
  VerificationContext validateIntegrity(Insertable<WikiItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(_summaryMeta,
          summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta));
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    if (data.containsKey('introduction')) {
      context.handle(
          _introductionMeta,
          introduction.isAcceptableOrUnknown(
              data['introduction']!, _introductionMeta));
    } else if (isInserting) {
      context.missing(_introductionMeta);
    }
    if (data.containsKey('created_on')) {
      context.handle(_createdOnMeta,
          createdOn.isAcceptableOrUnknown(data['created_on']!, _createdOnMeta));
    }
    if (data.containsKey('last_modified')) {
      context.handle(
          _lastModifiedMeta,
          lastModified.isAcceptableOrUnknown(
              data['last_modified']!, _lastModifiedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WikiItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WikiItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      summary: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}summary'])!,
      introduction: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}introduction'])!,
      sectionsTitles: $WikiItemsTable.$convertersectionsTitles.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}sections_titles'])!),
      sectionsContents: $WikiItemsTable.$convertersectionsContents.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}sections_contents'])!),
      createdOn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_on'])!,
      lastModified: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_modified'])!,
    );
  }

  @override
  $WikiItemsTable createAlias(String alias) {
    return $WikiItemsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<StringList, String, Object?>
      $convertersectionsTitles = StringList.converter;
  static JsonTypeConverter2<StringList, String, Object?>
      $convertersectionsContents = StringList.converter;
}

class WikiItem extends DataClass implements Insertable<WikiItem> {
  final int id;
  final String title;
  final String summary;
  final String introduction;
  final StringList sectionsTitles;
  final StringList sectionsContents;
  final DateTime createdOn;
  final DateTime lastModified;
  const WikiItem(
      {required this.id,
      required this.title,
      required this.summary,
      required this.introduction,
      required this.sectionsTitles,
      required this.sectionsContents,
      required this.createdOn,
      required this.lastModified});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['summary'] = Variable<String>(summary);
    map['introduction'] = Variable<String>(introduction);
    {
      map['sections_titles'] = Variable<String>(
          $WikiItemsTable.$convertersectionsTitles.toSql(sectionsTitles));
    }
    {
      map['sections_contents'] = Variable<String>(
          $WikiItemsTable.$convertersectionsContents.toSql(sectionsContents));
    }
    map['created_on'] = Variable<DateTime>(createdOn);
    map['last_modified'] = Variable<DateTime>(lastModified);
    return map;
  }

  WikiItemsCompanion toCompanion(bool nullToAbsent) {
    return WikiItemsCompanion(
      id: Value(id),
      title: Value(title),
      summary: Value(summary),
      introduction: Value(introduction),
      sectionsTitles: Value(sectionsTitles),
      sectionsContents: Value(sectionsContents),
      createdOn: Value(createdOn),
      lastModified: Value(lastModified),
    );
  }

  factory WikiItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WikiItem(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      summary: serializer.fromJson<String>(json['summary']),
      introduction: serializer.fromJson<String>(json['introduction']),
      sectionsTitles: $WikiItemsTable.$convertersectionsTitles
          .fromJson(serializer.fromJson<Object?>(json['sectionsTitles'])),
      sectionsContents: $WikiItemsTable.$convertersectionsContents
          .fromJson(serializer.fromJson<Object?>(json['sectionsContents'])),
      createdOn: serializer.fromJson<DateTime>(json['createdOn']),
      lastModified: serializer.fromJson<DateTime>(json['lastModified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'summary': serializer.toJson<String>(summary),
      'introduction': serializer.toJson<String>(introduction),
      'sectionsTitles': serializer.toJson<Object?>(
          $WikiItemsTable.$convertersectionsTitles.toJson(sectionsTitles)),
      'sectionsContents': serializer.toJson<Object?>(
          $WikiItemsTable.$convertersectionsContents.toJson(sectionsContents)),
      'createdOn': serializer.toJson<DateTime>(createdOn),
      'lastModified': serializer.toJson<DateTime>(lastModified),
    };
  }

  WikiItem copyWith(
          {int? id,
          String? title,
          String? summary,
          String? introduction,
          StringList? sectionsTitles,
          StringList? sectionsContents,
          DateTime? createdOn,
          DateTime? lastModified}) =>
      WikiItem(
        id: id ?? this.id,
        title: title ?? this.title,
        summary: summary ?? this.summary,
        introduction: introduction ?? this.introduction,
        sectionsTitles: sectionsTitles ?? this.sectionsTitles,
        sectionsContents: sectionsContents ?? this.sectionsContents,
        createdOn: createdOn ?? this.createdOn,
        lastModified: lastModified ?? this.lastModified,
      );
  WikiItem copyWithCompanion(WikiItemsCompanion data) {
    return WikiItem(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      summary: data.summary.present ? data.summary.value : this.summary,
      introduction: data.introduction.present
          ? data.introduction.value
          : this.introduction,
      sectionsTitles: data.sectionsTitles.present
          ? data.sectionsTitles.value
          : this.sectionsTitles,
      sectionsContents: data.sectionsContents.present
          ? data.sectionsContents.value
          : this.sectionsContents,
      createdOn: data.createdOn.present ? data.createdOn.value : this.createdOn,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WikiItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('summary: $summary, ')
          ..write('introduction: $introduction, ')
          ..write('sectionsTitles: $sectionsTitles, ')
          ..write('sectionsContents: $sectionsContents, ')
          ..write('createdOn: $createdOn, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, summary, introduction,
      sectionsTitles, sectionsContents, createdOn, lastModified);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WikiItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.summary == this.summary &&
          other.introduction == this.introduction &&
          other.sectionsTitles == this.sectionsTitles &&
          other.sectionsContents == this.sectionsContents &&
          other.createdOn == this.createdOn &&
          other.lastModified == this.lastModified);
}

class WikiItemsCompanion extends UpdateCompanion<WikiItem> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> summary;
  final Value<String> introduction;
  final Value<StringList> sectionsTitles;
  final Value<StringList> sectionsContents;
  final Value<DateTime> createdOn;
  final Value<DateTime> lastModified;
  const WikiItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.summary = const Value.absent(),
    this.introduction = const Value.absent(),
    this.sectionsTitles = const Value.absent(),
    this.sectionsContents = const Value.absent(),
    this.createdOn = const Value.absent(),
    this.lastModified = const Value.absent(),
  });
  WikiItemsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String summary,
    required String introduction,
    required StringList sectionsTitles,
    required StringList sectionsContents,
    this.createdOn = const Value.absent(),
    this.lastModified = const Value.absent(),
  })  : title = Value(title),
        summary = Value(summary),
        introduction = Value(introduction),
        sectionsTitles = Value(sectionsTitles),
        sectionsContents = Value(sectionsContents);
  static Insertable<WikiItem> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? summary,
    Expression<String>? introduction,
    Expression<String>? sectionsTitles,
    Expression<String>? sectionsContents,
    Expression<DateTime>? createdOn,
    Expression<DateTime>? lastModified,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (summary != null) 'summary': summary,
      if (introduction != null) 'introduction': introduction,
      if (sectionsTitles != null) 'sections_titles': sectionsTitles,
      if (sectionsContents != null) 'sections_contents': sectionsContents,
      if (createdOn != null) 'created_on': createdOn,
      if (lastModified != null) 'last_modified': lastModified,
    });
  }

  WikiItemsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? summary,
      Value<String>? introduction,
      Value<StringList>? sectionsTitles,
      Value<StringList>? sectionsContents,
      Value<DateTime>? createdOn,
      Value<DateTime>? lastModified}) {
    return WikiItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      introduction: introduction ?? this.introduction,
      sectionsTitles: sectionsTitles ?? this.sectionsTitles,
      sectionsContents: sectionsContents ?? this.sectionsContents,
      createdOn: createdOn ?? this.createdOn,
      lastModified: lastModified ?? this.lastModified,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (introduction.present) {
      map['introduction'] = Variable<String>(introduction.value);
    }
    if (sectionsTitles.present) {
      map['sections_titles'] = Variable<String>(
          $WikiItemsTable.$convertersectionsTitles.toSql(sectionsTitles.value));
    }
    if (sectionsContents.present) {
      map['sections_contents'] = Variable<String>($WikiItemsTable
          .$convertersectionsContents
          .toSql(sectionsContents.value));
    }
    if (createdOn.present) {
      map['created_on'] = Variable<DateTime>(createdOn.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<DateTime>(lastModified.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WikiItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('summary: $summary, ')
          ..write('introduction: $introduction, ')
          ..write('sectionsTitles: $sectionsTitles, ')
          ..write('sectionsContents: $sectionsContents, ')
          ..write('createdOn: $createdOn, ')
          ..write('lastModified: $lastModified')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WikiItemsTable wikiItems = $WikiItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [wikiItems];
}

typedef $$WikiItemsTableCreateCompanionBuilder = WikiItemsCompanion Function({
  Value<int> id,
  required String title,
  required String summary,
  required String introduction,
  required StringList sectionsTitles,
  required StringList sectionsContents,
  Value<DateTime> createdOn,
  Value<DateTime> lastModified,
});
typedef $$WikiItemsTableUpdateCompanionBuilder = WikiItemsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String> summary,
  Value<String> introduction,
  Value<StringList> sectionsTitles,
  Value<StringList> sectionsContents,
  Value<DateTime> createdOn,
  Value<DateTime> lastModified,
});

class $$WikiItemsTableFilterComposer
    extends Composer<_$AppDatabase, $WikiItemsTable> {
  $$WikiItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get introduction => $composableBuilder(
      column: $table.introduction, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<StringList, StringList, String>
      get sectionsTitles => $composableBuilder(
          column: $table.sectionsTitles,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<StringList, StringList, String>
      get sectionsContents => $composableBuilder(
          column: $table.sectionsContents,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get createdOn => $composableBuilder(
      column: $table.createdOn, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified, builder: (column) => ColumnFilters(column));
}

class $$WikiItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $WikiItemsTable> {
  $$WikiItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get introduction => $composableBuilder(
      column: $table.introduction,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sectionsTitles => $composableBuilder(
      column: $table.sectionsTitles,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sectionsContents => $composableBuilder(
      column: $table.sectionsContents,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdOn => $composableBuilder(
      column: $table.createdOn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified,
      builder: (column) => ColumnOrderings(column));
}

class $$WikiItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WikiItemsTable> {
  $$WikiItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get introduction => $composableBuilder(
      column: $table.introduction, builder: (column) => column);

  GeneratedColumnWithTypeConverter<StringList, String> get sectionsTitles =>
      $composableBuilder(
          column: $table.sectionsTitles, builder: (column) => column);

  GeneratedColumnWithTypeConverter<StringList, String> get sectionsContents =>
      $composableBuilder(
          column: $table.sectionsContents, builder: (column) => column);

  GeneratedColumn<DateTime> get createdOn =>
      $composableBuilder(column: $table.createdOn, builder: (column) => column);

  GeneratedColumn<DateTime> get lastModified => $composableBuilder(
      column: $table.lastModified, builder: (column) => column);
}

class $$WikiItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WikiItemsTable,
    WikiItem,
    $$WikiItemsTableFilterComposer,
    $$WikiItemsTableOrderingComposer,
    $$WikiItemsTableAnnotationComposer,
    $$WikiItemsTableCreateCompanionBuilder,
    $$WikiItemsTableUpdateCompanionBuilder,
    (WikiItem, BaseReferences<_$AppDatabase, $WikiItemsTable, WikiItem>),
    WikiItem,
    PrefetchHooks Function()> {
  $$WikiItemsTableTableManager(_$AppDatabase db, $WikiItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WikiItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WikiItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WikiItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> summary = const Value.absent(),
            Value<String> introduction = const Value.absent(),
            Value<StringList> sectionsTitles = const Value.absent(),
            Value<StringList> sectionsContents = const Value.absent(),
            Value<DateTime> createdOn = const Value.absent(),
            Value<DateTime> lastModified = const Value.absent(),
          }) =>
              WikiItemsCompanion(
            id: id,
            title: title,
            summary: summary,
            introduction: introduction,
            sectionsTitles: sectionsTitles,
            sectionsContents: sectionsContents,
            createdOn: createdOn,
            lastModified: lastModified,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String summary,
            required String introduction,
            required StringList sectionsTitles,
            required StringList sectionsContents,
            Value<DateTime> createdOn = const Value.absent(),
            Value<DateTime> lastModified = const Value.absent(),
          }) =>
              WikiItemsCompanion.insert(
            id: id,
            title: title,
            summary: summary,
            introduction: introduction,
            sectionsTitles: sectionsTitles,
            sectionsContents: sectionsContents,
            createdOn: createdOn,
            lastModified: lastModified,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WikiItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WikiItemsTable,
    WikiItem,
    $$WikiItemsTableFilterComposer,
    $$WikiItemsTableOrderingComposer,
    $$WikiItemsTableAnnotationComposer,
    $$WikiItemsTableCreateCompanionBuilder,
    $$WikiItemsTableUpdateCompanionBuilder,
    (WikiItem, BaseReferences<_$AppDatabase, $WikiItemsTable, WikiItem>),
    WikiItem,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WikiItemsTableTableManager get wikiItems =>
      $$WikiItemsTableTableManager(_db, _db.wikiItems);
}
