class Wiki {
  const Wiki(this.title, this.summary, this.contents, this.createdOn, this.lastModified);
  final String title;
  final String? summary;
  final String? contents;
  final DateTime lastModified;
  final DateTime createdOn;
}