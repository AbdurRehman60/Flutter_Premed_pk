class DeckInformation {
  DeckInformation({
    required this.success,
    required this.result,
    required this.alreadyAttempted,
    required this.lastAttempt,
    required this.attemptMode,
    required this.questions,
    this.correctAttempts,
    this.incorrectAttempts,
    this.skippedAttempts,
  });

  factory DeckInformation.fromJson(Map<String, dynamic> json) {
    final List<String> questions = (json['result']?['questions'] as List<dynamic>?)
        ?.map((question) => question as String)
        .toList() ?? [];

    return DeckInformation(
      success: json['success'] ?? false,
      result: json['result'] ?? <String, dynamic>{},
      alreadyAttempted: json['AlreadyAttempted'] ?? false,
      lastAttempt: json['lastAttempt'] ?? <String, dynamic>{},
      attemptMode: json['lastAttempt']?['attemptMode'] ?? '',
      questions: questions,
      correctAttempts: json['correctAttempts'],
      incorrectAttempts: json['incorrectAttempts'],
      skippedAttempts: json['skippedAttempts'],
    );
  }

  final bool success;
  final Map<String, dynamic> result;
  final bool alreadyAttempted;
  final Map<String, dynamic> lastAttempt;
  final String attemptMode;
  final List<String> questions;
  int? correctAttempts;
  int? incorrectAttempts;
  int? skippedAttempts;


  // Helper method to extract attempts from the last attempt
  List<Map<String, dynamic>> get attempts => (lastAttempt['attempts'] as List<dynamic>?)
      ?.map((attempt) => attempt as Map<String, dynamic>)
      .toList() ?? [];

  // Fetches the last attempt ID
  String get lastAttemptId => lastAttempt['_id'] ?? '';

  // Retrieves user's selection for a specific question by ID
  String? getSelectionForQuestion(String questionId, String attemptId) {
    final attempt = attempts.firstWhere(
          (attempt) => attempt['questionId'] == questionId && attempt['attemptId'] == attemptId,
      orElse: () => <String, dynamic>{},
    );
    return attempt['selection'] as String?;
  }

  // Checks if a specific question was attempted
  bool wasQuestionAttempted(String questionId) {
    return attempts.any((attempt) => attempt['questionId'] == questionId && attempt['attempted'] == true);
  }
}

class Attempts {
  Attempts({
    this.id,
    this.deckId,
    this.userId,
    this.attempts,
    this.attemptMode,
    this.metadata,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.correctAttempts,
    this.incorrectAttempts,
    this.skippedAttempts,
    this.totalTimeTaken,
  });

  factory Attempts.fromJson(Map<String, dynamic> json) {
    return Attempts(
      id: json['_id'],
      deckId: json['deckId'],
      userId: json['userId'],
      attempts: (json['attempts'] as List?)
          ?.map((e) => AttemptOfQuestions.fromJson(e))
          .toList(),
      attemptMode: json['attemptMode'],
      metadata: json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      correctAttempts: json['correctAttempts'],
      incorrectAttempts: json['incorrectAttempts'],
      skippedAttempts: json['skippedAttempts'],
      totalTimeTaken: json['totalTimeTaken'],
    );
  }

  String? id;
  String? deckId;
  String? userId;
  List<AttemptOfQuestions>? attempts;
  String? attemptMode;
  Metadata? metadata;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? correctAttempts;
  int? incorrectAttempts;
  int? skippedAttempts;
  int? totalTimeTaken;
}

class AttemptOfQuestions {
  AttemptOfQuestions({
    this.attemptId,
    required this.questionId,
    this.selection,
    this.timeTaken,
    this.subject,
    this.correctAnswer,
    this.isCorrect,
    this.attempted,
  });

  factory AttemptOfQuestions.fromJson(Map<String, dynamic> json) {
    return AttemptOfQuestions(
      attemptId: json['attemptId'],
      questionId: json['questionId'],
      selection: json['selection'],
      timeTaken: json['timeTaken'],
      subject: json['subject'],
      correctAnswer: json['correctAnswer'],
      isCorrect: json['isCorrect'] == true,
      attempted: json['attempted'] == true,
    );
  }

  String? attemptId;
  String? questionId;
  String? selection;
  int? timeTaken;
  String? subject;
  String? correctAnswer;
  bool? isCorrect;
  bool? attempted;
}

class Metadata {
  Metadata({
    this.entity,
    this.category,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      entity: json['entity'],
      category: json['category'],
    );
  }

  String? entity;
  String? category;
}
