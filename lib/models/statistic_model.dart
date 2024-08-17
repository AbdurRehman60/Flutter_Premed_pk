class UserStatModel {
  UserStatModel(
      {required this.decksAttempted,
      required this.testAttempted,
      required this.totalQuestionCorrect,
      required this.paracticeTestAttempted,
      required this.totalTimeTaken,
      required this.avgTimePerQuestion,
      required this.totalQuestionAttempted,
      required this.userStatid,
      required this.userId,
      required this.subjectAttempts});

  factory UserStatModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> subjectAttemptsJson = json['subjectAttempts'];
    final List<SubjectAttempt> subjectAttemptsList = subjectAttemptsJson
        .map(
            (subjectAttemptJson) => SubjectAttempt.fromJson(subjectAttemptJson))
        .toList();

    return UserStatModel(
      decksAttempted: json['decksAttempted'],
      testAttempted: json['testsAttempted'],
      totalQuestionCorrect: json['totalQuestionsCorrect'],
      paracticeTestAttempted: json['practiceAttempted'],
      totalTimeTaken: json['totalTimeTaken'],
      avgTimePerQuestion: json['avgTimePerQuestion'],
      totalQuestionAttempted: json['totalQuestionsAttempted'],
      userStatid: json['_id'],
      userId: json['userId'],
      subjectAttempts: subjectAttemptsList,
    );
  }

  final String userStatid;
  final String userId;
  final int totalQuestionAttempted;
  final int totalQuestionCorrect;
  final int decksAttempted;
  final int testAttempted;
  final int paracticeTestAttempted;
  final int totalTimeTaken;
   var avgTimePerQuestion;
  final List<SubjectAttempt> subjectAttempts;
}

class SubjectAttempt {
  SubjectAttempt({
    required this.subject,
    required this.totalQuestionsAttempted,
    required this.totalQuestionsCorrect,
    required this.totalQuestionsIncorrect,
  });

  factory SubjectAttempt.fromJson(Map<String, dynamic> json) {
    return SubjectAttempt(
      subject: json['subject'],
      totalQuestionsAttempted: json['totalQuestionsAttempted'],
      totalQuestionsCorrect: json['totalQuestionsCorrect'],
      totalQuestionsIncorrect: json['totalQuestionsIncorrect'],
    );
  }
  final String subject;
  final int totalQuestionsAttempted;
  final int totalQuestionsCorrect;
  final int totalQuestionsIncorrect;
}
