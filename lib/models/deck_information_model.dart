class DeckInformation {
  DeckInformation({
    required this.success,
    required this.result,
    required this.alreadyAttempted,
    required this.lastAttempt,
    required this.attemptMode,
    required this.questions,
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
    );
  }

  final bool success;
  final Map<String, dynamic> result;
  final bool alreadyAttempted;
  final Map<String, dynamic> lastAttempt;
  final String attemptMode;
  final List<String> questions;

  List<Map<String, dynamic>> get attempts => (lastAttempt['attempts'] as List<dynamic>?)
      ?.map((attempt) => attempt as Map<String, dynamic>)
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
