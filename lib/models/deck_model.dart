class DeckModel {

  DeckModel(
      {
        // required this.categoryName,
        required this.deckID,
        required this.deckGrpName,
        required this.deckGroupImage,
        required this.deckGroupLenght,
        required this.subDeckDetails,
        required this.deckType

      });

  factory DeckModel.fromJson(Map<String, dynamic> json) {
    return DeckModel(
      // categoryName: json['categoryName'],
      deckID: json['_id'],
      deckGrpName: json['deckGroupName'],
      deckGroupImage: json['deckGroupImage'],
      deckGroupLenght: json['decks'].length,
      subDeckDetails: json['decks'],
      deckType: json['deckType'],
    );
  }
  // final String categoryName;
  final String deckID;
  final String deckGroupImage;
  final String deckGrpName;
  final int deckGroupLenght;
  final List subDeckDetails;
  final String deckType;
}

class SubDeckModel {
  SubDeckModel({required this.deckTitle, required this.deckLogo, required this.premiumTag,});

  factory SubDeckModel.fromJson(Map<String, dynamic> json) {
    return SubDeckModel(
      deckTitle: json['deckTitle'] as String,
      deckLogo: json['deckLogo'] as String,
      premiumTag: json['premiumTags'][0] as String,
    );
  }

  final String deckTitle;
  final String deckLogo;
  final String premiumTag;

}
