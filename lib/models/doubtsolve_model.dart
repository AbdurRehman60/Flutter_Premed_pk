class Doubt {
  final String id;
  final String username;
  final String description;
  final String subject;
  final String? topic;
  final String resource;
  final String videoLink;
  final String expertUsername;
  final bool rated;
  final bool disputed;
  final String disputedUsername;
  final int disputedTimes;
  final String solvedStatus;
  final String timestamp;

  Doubt({
    required this.id,
    required this.username,
    required this.description,
    required this.subject,
    required this.resource,
    this.topic,
    required this.videoLink,
    required this.expertUsername,
    required this.rated,
    required this.disputed,
    required this.disputedUsername,
    required this.disputedTimes,
    required this.solvedStatus,
    required this.timestamp,
  });

  factory Doubt.fromJson(Map<String, dynamic> json) {
    return Doubt(
      id: json['_id'],
      username: json['username'],
      description: json['description'],
      subject: json['subject'],
      topic: json['topic'] ?? '',
      resource: json['resource'],
      videoLink: json['videoLink'],
      expertUsername: json['expertUsername'],
      rated: json['rated'],
      disputed: json['disputed'],
      disputedUsername: json['disputedUsername'] ?? '',
      disputedTimes: json['disputedTimes'],
      solvedStatus: json['solvedStatus'],
      timestamp: json['timestamp'],
    );
  }
}

class QuestionsResponse {
  final bool success;
  final List<Doubt> questionsDetails;

  QuestionsResponse({
    required this.success,
    required this.questionsDetails,
  });

  factory QuestionsResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> DoubtJson = json['QuestionsDetails'];
    List<Doubt> questionsDetails =
        DoubtJson.map((item) => Doubt.fromJson(item)).toList();

    return QuestionsResponse(
      success: json['success'],
      questionsDetails: questionsDetails,
    );
  }
}
