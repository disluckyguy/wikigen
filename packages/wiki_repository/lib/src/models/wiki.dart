class Section {
  const Section(this.title, this.contents);
  final String title;
  final String contents;
}

class Wiki {
  const Wiki(this.title, this.summary, this.introduction, this.sections,
      this.createdOn, this.lastModified);
  final String title;
  final String summary;
  final String introduction;
  final List<Section> sections;
  final DateTime lastModified;
  final DateTime createdOn;
}
