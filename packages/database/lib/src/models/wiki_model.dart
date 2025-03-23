class WikiModel {
  int id;
  String title;
  String summary;
  String introduction;
  List<String> sectionsTitles;
  List<String> sectionsContents;
  DateTime lastModified;
  DateTime createdOn;

  WikiModel(this.id, this.title, this.summary, this.introduction, this.sectionsTitles, this.sectionsContents, this.createdOn, this.lastModified);
}
