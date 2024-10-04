class PaperResponse {
  PaperResponse({
    required this.success,
    required this.result,
    required this.alreadyAttempted,
    required this.lastAttempt,
    required this.attemptMode,
    required this.questions,
    required this.lastDone
  });

  factory PaperResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> resultList = json['result'] as List<dynamic>? ?? [];

    final result = resultList.isNotEmpty
        ? (resultList.first as Map<dynamic, dynamic>).cast<String, dynamic>()
        : <String, dynamic>{};

    final List<String> questions = (result['questions'] as List<dynamic>?)
        ?.map((question) => question as String)
        .toList() ?? [];

    print('Parsed Questions: $questions');

    return PaperResponse(
        success: json['success'] ?? false,
        result: result,
        alreadyAttempted: json['AlreadyAttempted'] ?? false,
        lastAttempt: json['lastAttempt'] ?? <String, dynamic>{},
        attemptMode: json['lastAttempt']?['attemptMode'] ?? '',
        questions: questions,
        lastDone: json['lastDone'] is String ? json['lastDone'] : ''
    );
  }

  final bool success;
  final Map<String, dynamic> result;
  final bool alreadyAttempted;
  final Map<String, dynamic> lastAttempt;
  final String attemptMode;
  final List<String> questions;
  final String lastDone;

  List<Map<String, dynamic>> get attempts => (lastAttempt['attempts'] as List<dynamic>?)
      ?.map((attempt) => (attempt as Map<dynamic, dynamic>).cast<String, dynamic>())
      .toList() ?? [];

  String get lastAttemptId => lastAttempt['_id'] ?? '';

  String? getSelectionForQuestion(String questionId) {
    final attempt = attempts.firstWhere(
          (attempt) => attempt['questionId'] == questionId,
      orElse: () => <String, dynamic>{},
    );
    return attempt['selection'] as String?;
  }
}

class Paper {

  Paper({
    required this.id,
    required this.deckName,
    this.isTutorModeFree = false,
    this.isMock = false,
    this.timedTestMode = false,
    this.timedTestMinutes = 0,
    required this.questions,
  });

  factory Paper.fromJson(Map<String, dynamic> json) {
    return Paper(
      id: json['_id'],
      deckName: json['deckName'] ?? 'Unknown',
      isTutorModeFree: json['isTutorModeFree'] ?? false,
      isMock: json['isMock'] ?? false,
      timedTestMode: json['timedTestMode'] ?? false,
      timedTestMinutes: json['timedTestMinutes'] ?? 0,
      questions: List<String>.from(json['questions'] ?? []),
    );
  }
  final String id;
  final String deckName;
  final bool isTutorModeFree;
  final bool isMock;
  final bool timedTestMode;
  final int timedTestMinutes;
  final List<String> questions;
}

class Metadata {

  Metadata({
    required this.entity,
    required this.category,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      entity: json['entity'],
      category: json['category'],
    );
  }
  final String entity;
  final String category;
}