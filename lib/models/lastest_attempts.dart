class LatestAttempt {
  LatestAttempt({this.id, this.results});

  factory LatestAttempt.fromJson(Map<String, dynamic> json) {
    return LatestAttempt(
      id: json['_id'],
      results: json['results'] != null
          ? (json['results'] as List).map((e) => Result.fromJson(e)).toList()
          : null,
    );
  }

  String? id;
  List<Result>? results;
}

class Result {
  Result(
      {this.attempts,
      this.deckCollection,
      this.attemptedDate,
      this.totalAttempts,
      this.mode,
      this.deckName,
      this.totalQuestions});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      attempts: json['attempts'] != null
          ? AttemptsCollection.fromJson(json['attempts'])
          : null,
      deckCollection: json['deckCollection'] != null
          ? DeckCollection.fromJson(json['deckCollection'])
          : null,
      attemptedDate: DateTime.parse(json['attemptedDate']),
      totalAttempts: json['totalAttempts'],
      mode: json['mode'],
      deckName: json['deckName'],
      totalQuestions: json['totalQuestions'],
    );
  }

  AttemptsCollection? attempts;
  DeckCollection? deckCollection;
  DateTime? attemptedDate;
  int? totalAttempts;
  String? mode;
  String? deckName;
  int? totalQuestions;
}

class AttemptsCollection {
  AttemptsCollection(
      {this.attemptId, this.deckId, this.attemptMode, this.attempts});

  factory AttemptsCollection.fromJson(Map<String, dynamic> json) {
    return AttemptsCollection(
      attemptId: json['attemptId'],
      deckId: json['deckId'],
      attemptMode: json['attemptMode'],
      attempts: json['attempts'] != null
          ? (json['attempts'] as List).map((e) => Attempts.fromJson(e)).toList()
          : null,
    );
  }

  String? attemptId;
  String? deckId;
  String? attemptMode;
  List<Attempts>? attempts;
}

class Attempts {
  Attempts({this.questionId, this.answer});

  factory Attempts.fromJson(Map<String, dynamic> json) {
    return Attempts(
      questionId: json['questionId'],
      answer: json['answer'],
    );
  }

  String? questionId;
  String? answer;
}

class DeckCollection {
  DeckCollection({this.deckId, this.deckName, this.questions});

  factory DeckCollection.fromJson(Map<String, dynamic> json) {
    return DeckCollection(
      deckId: json['deckId'],
      deckName: json['deckName'],
      questions: json['questions'] != null
          ? (json['questions'] as List)
              .map((e) => Questions.fromJson(e))
              .toList()
          : null,
    );
  }

  String? deckId;
  String? deckName;
  List<Questions>? questions;
}

class Questions {
  Questions({this.questionId, this.question});

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      questionId: json['questionId'],
      question: json['question'],
    );
  }

  String? questionId;
  String? question;
}

class Attempt {
  Attempt({
    required this.id,
    required this.deckId,
    required this.userId,
    required this.attempts,
    required this.attemptMode,
    required this.metadata,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.attemptedDate,
    required this.totalAttempts,
    required this.mode,
    required this.deckName,
    required this.totalQuestions,
  });

  factory Attempt.fromJson(Map<String, dynamic> json) {
    final attemptsJson = json['attempts'];
    return Attempt(
      id: attemptsJson['_id'] ?? '',
      deckId: attemptsJson['deckId'] ?? '',
      userId: attemptsJson['userId'] ?? '',
      attempts: attemptsJson['attempts'] ?? [],
      attemptMode: attemptsJson['attemptMode'] ?? '',
      metadata: Metadata.fromJson(attemptsJson['metadata'] ?? {}),
      createdAt: attemptsJson['createdAt'] ?? '',
      updatedAt: attemptsJson['updatedAt'] ?? '',
      v: attemptsJson['__v'] ?? 0,
      attemptedDate: json['attemptedDate'] ?? '',
      totalAttempts: json['totalAttempts'] ?? 0,
      mode: json['mode'] ?? '',
      deckName: json['deckName'] ?? '',
      totalQuestions: json['totalQuestions'] ?? 0,
    );
  }
  final String id;
  final String deckId;
  final String userId;
  final List<dynamic> attempts;
  final String attemptMode;
  final Metadata metadata;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String attemptedDate;
  final int totalAttempts;
  final String mode;
  final String deckName;
  final int totalQuestions;
}

class Metadata {
  Metadata({required this.entity, required this.category});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      entity: json['entity'] ?? '',
      category: json['category'] ?? '',
    );
  }
  final String entity;
  final String category;
}
