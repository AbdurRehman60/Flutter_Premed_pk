class DeckGroupModel {
  final String deckGroupName;
  final int deckNameCount;
  final String? deckGroupImage;


  DeckGroupModel({
    required this.deckGroupName,
    required this.deckNameCount,
    this.deckGroupImage,
  });


  factory DeckGroupModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> deckNames = json['decks'].map((deck) => deck['deckName']).toList();
    final int deckNameCount = deckNames.length;
    final String? deckGroupImage = json['deckGroupImage'];

    return DeckGroupModel(
      deckGroupName: json['deckGroupName'],
      deckNameCount: deckNameCount,
      deckGroupImage: deckGroupImage,
    );
  }
}
