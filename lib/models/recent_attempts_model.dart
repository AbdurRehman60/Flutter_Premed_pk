class RecentAttempt {
  RecentAttempt({
    this.id,
    this.attempts,
    this.attemptedDate,
    this.totalAttempts,
    this.mode,
    this.deckName,
    this.totalQuestions,
  });

  factory RecentAttempt.fromJson(Map<String, dynamic> json) {
    return RecentAttempt(
      id: json['attempts']['_id'],
      attempts: json['attempts'] != null ? Attempts.fromJson(json['attempts']) : null,
      attemptedDate: DateTime.parse(json['attemptedDate']),
      totalAttempts: json['totalAttempts'],
      mode: json['mode'],
      deckName: json['deckName'],
      totalQuestions: json['totalQuestions'],
    );
  }

  String? id;
  Attempts? attempts;
  DateTime? attemptedDate;
  int? totalAttempts;
  String? mode;
  String? deckName;
  int? totalQuestions;

  String? get subject => attempts?.attempts?.first.subject;

  String? get category => attempts?.metadata?.category;
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
          ?.map((e) => AttemptofQuestions.fromJson(e))
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
  List<AttemptofQuestions>? attempts;
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

class AttemptofQuestions {
  AttemptofQuestions({
    this.attemptId,
    required this.questionId,
    this.selection,
    this.timeTaken,
    this.subject,
    this.correctAnswer,
    this.isCorrect,
    this.attempted,
  });

  factory AttemptofQuestions.fromJson(Map<String, dynamic> json) {
    return AttemptofQuestions(
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
