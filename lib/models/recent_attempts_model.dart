class RecentAttempt {
  RecentAttempt({
    this.attempts,
    this.attemptedDate,
    this.totalAttempts,
    this.mode,
    this.deckName,
    this.totalQuestions,
  });

  factory RecentAttempt.fromJson(Map<String, dynamic> json) {
    return RecentAttempt(
      attempts: Attempts.fromJson(json['attempts']),
      attemptedDate: DateTime.parse(json['attemptedDate']),
      totalAttempts: json['totalAttempts'],
      mode: json['mode'],
      deckName: json['deckName'],
      totalQuestions: json['totalQuestions'],
    );
  }

  Attempts? attempts;
  DateTime? attemptedDate;
  int? totalAttempts;
  String? mode;
  String? deckName;
  int? totalQuestions;
}

class Attempts {
  Attempts({
    this.id,
    this.deckId,
    this.userId,
    this.attempts,
    this.attemptMode,
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
      attempts:
          (json['attempts'] as List).map((e) => Attempt.fromJson(e)).toList(),
      attemptMode: json['attemptMode'],
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
  List<Attempt>? attempts;
  String? attemptMode;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? correctAttempts;
  int? incorrectAttempts;
  int? skippedAttempts;
  int? totalTimeTaken;
}

class Attempt {
  Attempt({
    required this.questionId,
    this.selection,
    this.timeTaken,
    this.subject,
    this.correctAnswer,
    this.isCorrect,
    this.attempted,
  });

  factory Attempt.fromJson(Map<String, dynamic> json) {
    return Attempt(
      questionId: json['questionId'],
      selection: json['selection'],
      timeTaken: json['timeTaken'],
      subject: json['subject'],
      correctAnswer: json['correctAnswer'],
      isCorrect: json['isCorrect'] is bool
          ? json['isCorrect']
          : json['isCorrect'] == 'true',
      attempted: json['attempted'] is bool
          ? json['attempted']
          : json['attempted'] == 'true',
    );
  }

  String? questionId;
  String? selection;
  int? timeTaken;
  String? subject;
  String? correctAnswer;
  bool? isCorrect;
  bool? attempted;
}
