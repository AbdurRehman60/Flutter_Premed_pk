class SavedQuestionPayload {

  SavedQuestionPayload({
    required this.userId,
    required this.subject,
    required this.questionId,
  });
  final String userId;
  final String subject;
  final String questionId;

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'subject': subject,
    'questionId': questionId,
  };
}
