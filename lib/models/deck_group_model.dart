class DeckGroupModel {
  DeckGroupModel({
    required this.deckGroupName,
    required this.deckNameCount,
    required this.deckItems,
    this.deckGroupImage,
    required this.deckType,
    required this.isPublished,
  });

  factory DeckGroupModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> deckData = json['decks'];
    final List<DeckItem> deckItems = deckData.map((deck) => DeckItem.fromJson(deck as Map<String, dynamic>)).toList();
    final int deckNameCount = deckItems.length;
    final String? deckGroupImage = json['deckGroupImage'];

    return DeckGroupModel(
      deckType: json['deckType'],
      deckGroupName: json['deckGroupName'],
      deckItems: deckItems,
      deckNameCount: deckNameCount,
      deckGroupImage: deckGroupImage,
      isPublished: json['isPublished'] as bool,
    );
  }

  final String deckGroupName;
  final List<DeckItem> deckItems;
  final int deckNameCount;
  final String? deckGroupImage;
  final String deckType;
  final bool isPublished;
}

class DeckItem {
  DeckItem({
    required this.deckName,
    required this.deckLogo,
    required this.premiumTag,
    required this.deckInstructions,
    required this.isTutorModeFree,
    required this.timedTestMode,
    required this.timesTestminutes,
    required this.isPublished,
  });

  factory DeckItem.fromJson(Map<String, dynamic> json) {

    return DeckItem(
      deckName: json['deckName'] as String,
      deckLogo: json['deckLogo'] as String,
      premiumTag: json['premiumTag'] as String?,
      deckInstructions: json['deckInstructions'] as String,
      isTutorModeFree: json['isTutorModeFree'] as bool?,
      timedTestMode: json['timedTestMode'] as bool?,
      timesTestminutes: json['timedTestMinutes'] as int?,
      isPublished: json['isPublished'] as bool,
    );
  }

  final String deckName;
  final String deckLogo;
  final String? premiumTag;
  final String deckInstructions;
  final bool? isTutorModeFree;
  final bool? timedTestMode;
  final int? timesTestminutes;
  final bool isPublished;
}
