// latest_attempt_model.dart

class LatestAttempt {
  LatestAttempt({this.id, this.results});

  factory LatestAttempt.fromJson(Map<String, dynamic> json) {
    return LatestAttempt(
      id: json['id'],
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
