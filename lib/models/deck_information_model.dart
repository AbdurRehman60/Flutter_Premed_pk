class DeckInformation {
  DeckInformation({
    required this.success,
    required this.result,
    required this.alreadyAttempted,
    required this.lastAttempt,
    required this.attemptMode,
  });

  factory DeckInformation.fromJson(Map<String, dynamic> json) {
    return DeckInformation(
      success: json['success'],
      result: json['result'] ?? <String, dynamic>{},
      alreadyAttempted: json['AlreadyAttempted'] ?? false,
      lastAttempt: json['lastAttempt'] ?? <String, dynamic>{},
      attemptMode: json['lastAttempt']?['attemptMode'] ?? '',
    );
  }

  final bool success;
  final Map<String, dynamic> result;
  final bool alreadyAttempted;
  final Map<String, dynamic> lastAttempt;
  final String attemptMode;

  List<Map<String, dynamic>> get attempts => (lastAttempt['attempts'] as List)
      .map((attempt) => attempt as Map<String, dynamic>)
      .toList();

  String get lastAttemptId => lastAttempt['_id'] ?? '';

  String? getSelectionForQuestion(String questionId) {
    final attempt = attempts.firstWhere(
          (attempt) => attempt['questionId'] == questionId,
      orElse: () => <String, dynamic>{},
    );
    return attempt['selection'] as String?;
  }
}
