import 'package:intl/intl.dart';

class RecentActivityModel {
  RecentActivityModel({
    required this.attemptsId,
    required this.deckId,
    required this.userId,
    required this.attemptedDate,
    required this.totalAttempts,
    required this.mode,
    required this.deckName,
    required this.totalQuestions,
  });

  factory RecentActivityModel.fromJson(Map<String, dynamic> json) {
    return RecentActivityModel(
      attemptsId: json['attempts']['_id'],
      deckId: json['attempts']['deckId'],
      userId: json['attempts']['userId'],
      attemptedDate: _formatDateTime(json['attemptedDate']),
      totalAttempts: json['totalAttempts'],
      mode: json['mode'],
      deckName: json['deckName'],
      totalQuestions: json['totalQuestions'],
    );
  }

  final String attemptsId;
  final String deckId;
  final String userId;
  final String attemptedDate;
  final int totalAttempts;
  final String mode;
  final String deckName;
  final int totalQuestions;

  static String _formatDateTime(String dateTimeString) {
    final DateTime dateTime = DateTime.parse(dateTimeString);
    final String formattedDate = DateFormat('d MMM y').format(dateTime);
    final String daySuffix = _getDaySuffix(dateTime.day);
    return formattedDate.replaceAllMapped(
        RegExp(r'(\d{1,2})(st|nd|rd|th)'), (Match m) => '${m[1]}$daySuffix');
  }

  static String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
