class ProvincialGuidesModel {

  ProvincialGuidesModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.province,
    required this.notesURL,
    required this.coverImageURL,
    required this.demarcations,
    required this.pages,
    required this.position,
    required this.createdAt,
    required this.updatedAt,
  });
  final String id;
  final String title;
  final String subject;
  final String province;
  final String notesURL;
  final String coverImageURL;
  final List<GuideDemarcation> demarcations;
  final int pages;
  final int position;
  final DateTime createdAt;
  final DateTime updatedAt;
}

class GuideDemarcation {

  GuideDemarcation({
    required this.id,
    required this.name,
    required this.page,
  });
  final String id;
  final String name;
  final int page;
}
