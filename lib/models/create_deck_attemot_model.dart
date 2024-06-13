class CreateDeckAttemptModel {
  CreateDeckAttemptModel({
    required this.deckName,
    required this.attemptMode,
    required this.user,
  });

  final String deckName;
  final String attemptMode;
  final String user;

  Map<String, dynamic> toJson() {
    return {
      'DeckName': deckName,
      'attemptMode': attemptMode,
      'user': user,
    };
  }
}
