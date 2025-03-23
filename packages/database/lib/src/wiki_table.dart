
import 'package:drift/drift.dart';
import 'package:json_annotation/json_annotation.dart';
part 'wiki_table.g.dart';

class WikiItems extends Table {
  IntColumn get id => integer().autoIncrement()(); 


  TextColumn get title => text()();
  TextColumn get summary => text()();
  TextColumn get introduction => text()();

  TextColumn get sectionsTitles =>
      text().map(StringList.converter)();

  TextColumn get sectionsContents =>
      text().map(StringList.converter)();

  DateTimeColumn get createdOn => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastModified => dateTime().withDefault(currentDateAndTime)();

}

@JsonSerializable()
class StringList {
  List<String> list;

  StringList(this.list);

  factory StringList.fromJson(Map<String, dynamic> json) => _$StringListFromJson(json);

  Map<String, dynamic> toJson() => _$StringListToJson(this);

  static JsonTypeConverter2<StringList, String, Object?> converter =
    TypeConverter.json2(
  fromJson: (json) => StringList.fromJson(json as Map<String, Object?>),
  toJson: (pref) => pref.toJson(),
);
}