class DeckGroupModel {
  DeckGroupModel({
    required this.deckGroupName,
    required this.deckItems,
    required this.deckType,
    required this.isPublished,
    this.deckGroupImage,
  }) : deckNameCount = deckItems.where((deck) => deck.isPublished).length;

  factory DeckGroupModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> deckData = json['decks'];
    final List<DeckItem> deckItems = deckData.map((deck) => DeckItem.fromJson(deck as Map<String, dynamic>)).toList();
    final String? deckGroupImage = json['deckGroupImage'];

    return DeckGroupModel(
      deckType: json['deckType'],
      deckGroupName: json['deckGroupName'],
      deckItems: deckItems,
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
    required this.premiumTags,
    required this.deckInstructions,
    required this.isTutorModeFree,
    required this.timedTestMode,
    required this.timesTestminutes,
    required this.isPublished,
  });

  factory DeckItem.fromJson(Map<String, dynamic> json) {
    final List? premiumTagsJson = json['premiumTags'] as List<dynamic>?;
    final List<String> premiumTags = premiumTagsJson != null
        ? premiumTagsJson.map((tag) => tag.toString()).toList()
        : [];

    return DeckItem(
      deckName: json['deckName'] as String,
      deckLogo: json['deckLogo'] as String,
      premiumTags: premiumTags,
      deckInstructions: json['deckInstructions'] as String? ?? '',
      isTutorModeFree: json['isTutorModeFree'] as bool? ?? false,
      timedTestMode: json['timedTestMode'] as bool? ?? false,
      timesTestminutes: json['timedTestMinutes'] as int? ?? 0,
      isPublished: json['isPublished'] as bool,
    );
  }

  final String deckName;
  final String deckLogo;
  final List<String> premiumTags;
  final String deckInstructions;
  final bool isTutorModeFree;
  final bool timedTestMode;
  final int timesTestminutes;
  final bool isPublished;
}
