class ResultMeta {

  ResultMeta({
    required this.attempted,
    required this.avgTimeTaken,
    required this.deckName,
    required this.negativesDueToWrong,
    required this.noOfNegativelyMarked,
    required this.totalMarks,
    required this.totalQuestions,
    required this.totalTimeTaken,
  });

  factory ResultMeta.fromJson(Map<String, dynamic> json) {
    return ResultMeta(
      attempted: json['attempted'] ?? 0,
      avgTimeTaken: json['avgTimeTaken']?.toDouble() ?? 0.0,
      deckName: json['deckName'] ?? '',
      negativesDueToWrong: json['negativesDueToWrong'] ?? 0,
      noOfNegativelyMarked: json['noOfNegativelyMarked'] ?? 0,
      totalMarks: json['totalMarks'] ?? 0,
      totalQuestions: json['totalQuestions'] ?? 0,
      totalTimeTaken: json['totalTimeTaken'] ?? 0,
    );
  }
  final int attempted;
  final double avgTimeTaken;
  final String deckName;
  final int negativesDueToWrong;
  final int noOfNegativelyMarked;
  final int totalMarks;
  final int totalQuestions;
  final int totalTimeTaken;

  Map<String, dynamic> toJson() {
    return {
      'attempted': attempted,
      'avgTimeTaken': avgTimeTaken,
      'deckName': deckName,
      'negativesDueToWrong': negativesDueToWrong,
      'noOfNegativelyMarked': noOfNegativelyMarked,
      'totalMarks': totalMarks,
      'totalQuestions': totalQuestions,
      'totalTimeTaken': totalTimeTaken,
    };
  }
}

class AttemptInfo {

  AttemptInfo({
    required this.deckName,
    required this.totalMarks,
    required this.totalTimeTaken,
    required this.avgTimeTaken,
    required this.attempted,
    required this.negativesDueToWrong,
    required this.noOfNegativelyMarked,
    required this.totalQuestions,
    required this.correctAttempts,
    required this.incorrectAttempts,
    required this.skippedAttempts,
  });

  factory AttemptInfo.fromJson(Map<String, dynamic> json) {
    return AttemptInfo(
      deckName: json['deckName'] ?? '',
      totalMarks: json['totalMarks'] ?? 0,
      totalTimeTaken: json['totalTimeTaken'] ?? 0,
      avgTimeTaken: (json['avgTimeTaken'] ?? 0).toDouble(),
      attempted: json['attempted'] ?? 0,
      negativesDueToWrong: json['negativesDueToWrong'] ?? 0,
      noOfNegativelyMarked: json['noOfNegativelyMarked'] ?? 0,
      totalQuestions: json['totalQuestions'] ?? 0,
      correctAttempts: json['correctAttempts'] ?? 0,
      incorrectAttempts: json['incorrectAttempts'] ?? 0,
      skippedAttempts: json['skippedAttempts'] ?? 0,
    );
  }
  final String deckName;
  final int totalMarks;
  final int totalTimeTaken;
  final double avgTimeTaken;
  final int attempted;
  final int negativesDueToWrong;
  final int noOfNegativelyMarked;
  final int totalQuestions;
  final int correctAttempts;
  final int incorrectAttempts;
  final int skippedAttempts;
}
