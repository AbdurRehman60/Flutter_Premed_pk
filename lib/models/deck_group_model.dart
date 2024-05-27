
class DeckGroupModel {


  DeckGroupModel({
    required this.deckGroupName,
    required this.deckNameCount,
    required this.deckItems,
    this.deckGroupImage,
  });


  factory DeckGroupModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> deckData = json['decks'];
    final List<DeckItem> deckItems = deckData.map((deck) => DeckItem.fromJson(deck as Map<String, dynamic>)).toList();
    final int deckNameCount = deckItems.length;
    final String? deckGroupImage = json['deckGroupImage'];

    return DeckGroupModel(
      deckGroupName: json['deckGroupName'],
      deckItems: deckItems,
      deckNameCount: deckNameCount,
      deckGroupImage: deckGroupImage,
    );
  }
  final String deckGroupName;
  final List<DeckItem> deckItems;
  final int deckNameCount;
  final String? deckGroupImage;
}

class DeckItem {
  DeckItem({
    required this.deckName,
    required this.deckLogo,
    required this.premiumTag,
    required this.deckInstructions,
  });

  factory DeckItem.fromJson(Map<String, dynamic> json) {
    return DeckItem(
      deckName: json['deckName'] as String,
      deckLogo: json['deckLogo'] as String,
      premiumTag: json['premiumTags'][0] as String,
      deckInstructions: json['deckInstructions'] as String,
    );
  }

  final String deckName;
  final String deckLogo;
  final String premiumTag;
  final String deckInstructions;
}
