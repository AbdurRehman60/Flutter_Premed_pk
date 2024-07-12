class AdditionModel {
  AdditionModel(
      {required this.additionTopic,
      required this.additionSubTopic,
      required this.aditionGrahicUrl});

  factory AdditionModel.fromjson(Map<String, dynamic> json) {
    return AdditionModel(
        additionTopic: json['additionTopic'],
        additionSubTopic: json['additionSubTopic'],
        aditionGrahicUrl: json['aditionGrahicUrl']);
  }

  final String additionTopic;
  final String additionSubTopic;
  final String aditionGrahicUrl;
}

List<AdditionModel> dummyAdditionList = [
  AdditionModel(
      additionTopic: 'classification of enzymes',
      additionSubTopic:
          'memorise the unpaired facial bones using the mnemonic.',
      aditionGrahicUrl: 'assets/images/vault/ad1.jpg'),
  AdditionModel(
      additionTopic: 'Biological Molecule.',
      additionSubTopic: 'High yield topical biology.',
      aditionGrahicUrl: 'assets/images/vault/ad2.jpg'),
  AdditionModel(
      additionTopic: 'Biological Molecule.',
      additionSubTopic: 'High yield topical biology.',
      aditionGrahicUrl: 'assets/images/vault/ad2.jpg'),
];
