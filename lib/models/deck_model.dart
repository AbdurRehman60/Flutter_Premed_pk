class DeckModel {
  // final String categoryName;
  final String deckID;
  final String deckGroupImage;
  final String deckGrpName;
  final int deckGroupLenght;
  final List subDeckDetails;
  DeckModel(
      {
      // required this.categoryName,
      required this.deckID,
      required this.deckGrpName,
      required this.deckGroupImage,
      required this.deckGroupLenght,
      required this.subDeckDetails

      });

  factory DeckModel.fromJson(Map<String, dynamic> json) {
    return DeckModel(
      // categoryName: json['categoryName'],
      deckID: json['_id'],
      deckGrpName: json['deckGroupName'],
      deckGroupImage: json['deckGroupImage'],
      deckGroupLenght: json['decks'].length,
      subDeckDetails: json['decks'],
    );
  }
}

class SubDeckModel {
  final String deckTitle;
  final String deckLogo;
  SubDeckModel({required this.deckTitle, required this.deckLogo});
}
