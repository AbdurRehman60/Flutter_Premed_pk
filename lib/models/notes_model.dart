class NoteModel {
  NoteModel({
    required this.id,
    required this.isGuide,
    required this.title,
    required this.subject,
    required this.province,
    required this.notesURL,
    required this.coverImageURL,
    this.demarcations,
    this.pages,
    this.position,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    List<NoteDemarcation> demarcations = [];

    if (json['demarcations'] != null) {
      demarcations = (json['demarcations'] as List)
          .map((demarcationJson) => NoteDemarcation.fromJson(demarcationJson))
          .toList();
    }

    return NoteModel(
      id: json['_id'],
      isGuide: json['isGuide'],
      title: json['title'],
      subject: json['subject'],
      province: json['province'],
      notesURL: json['notesURL'],
      coverImageURL: json['coverImageURL'],
      demarcations: demarcations,
      pages: json['pages'],
      position: json['position'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  final String id;
  final bool isGuide;
  final String title;
  final String subject;
  final String? province;
  final String notesURL;
  final String coverImageURL;
  final List<NoteDemarcation>? demarcations;
  final int? pages;
  final int? position;
  final DateTime createdAt;
  final DateTime updatedAt;
}

class NoteDemarcation {
  NoteDemarcation({
    required this.id,
    required this.name,
    required this.page,
  });

  factory NoteDemarcation.fromJson(Map<String, dynamic> json) {
    return NoteDemarcation(
      id: json['_id'],
      name: json['name'],
      page: json['page'] ?? 0,
    );
  }
  final String id;
  final String name;
  final int page;
}
