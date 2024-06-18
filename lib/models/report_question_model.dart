class ReportedQuestion {
  final String userId;
  final String questionId;
  final String problemText;
  final List<String> issues;

  ReportedQuestion({
    required this.userId,
    required this.questionId,
    required this.problemText,
    required this.issues,
  });
  factory ReportedQuestion.fromJson(Map<String, dynamic> json) {
    return ReportedQuestion(
      userId: json['userId'],
      questionId: json['questionId'],
      problemText: json['problemText'],
      issues: List<String>.from(json['issues']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'questionId': questionId,
      'problemText': problemText,
      'issues': issues,
    };
  }
}