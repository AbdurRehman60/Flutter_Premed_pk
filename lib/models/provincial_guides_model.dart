class ProvincialGuides {
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

  ProvincialGuides({
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
}

class GuideDemarcation {
  final String id;
  final String name;
  final int page;

  GuideDemarcation({
    required this.id,
    required this.name,
    required this.page,
  });
}
