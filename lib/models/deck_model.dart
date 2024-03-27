class DeckModel {
  final String categoryName;
  final String deckID;
  final String deckGroupImage;
  final String deckGrpName;
  final int deckGroupLenght;
  DeckModel(
      {required this.categoryName,
      required this.deckID,
      required this.deckGrpName,
      required this.deckGroupImage,
      required this.deckGroupLenght});

  factory DeckModel.fromJson(Map<String, dynamic> json) {
    return DeckModel(
        categoryName: json['categoryName'],
        deckID: json['_id'],
        deckGrpName: json['deckGroupName'],
        deckGroupImage: json['deckGroupImage'],
        deckGroupLenght: json['decks'].length);
  }
}
