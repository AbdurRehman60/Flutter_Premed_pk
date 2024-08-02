
class Subscription {
  Subscription({
    required this.planName,
    required this.name,
    required this.subscriptionEndDate,
    required this.subscriptionStartDate,
    required this.entityPart,
    required this.categoryPart,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    print('current subscription : ${json['planName']}');
    print('current subscription : ${json['name']}');
    print('current subscription : ${json['subscriptionEndDate']}');
    return Subscription(
      planName: json['planName'],
      name: json['name'],
      subscriptionEndDate: DateTime.parse(json['subscriptionEndDate']),
      subscriptionStartDate: DateTime.parse(json['subscriptionStartDate']),
      entityPart: json['entityPart'],
      categoryPart: json['categoryPart'],
    );
  }
  final String planName;
  final String name;
  final DateTime subscriptionEndDate;
  final DateTime subscriptionStartDate;
  final String entityPart;
  final String categoryPart;
}


const featuresAccess = [
  {
    'name': 'Notes',
    'accessTags': [
      "PreMed-Notes",
      "MDCAT-Notes",
      "AKU-Notes",
      "NUMS-Notes",
      "PreEng-Notes",
      "ECAT-Notes",
      "NUST-Notes",
      "FAST-Notes"
    ]
  },
  {
    'name': 'Guides',
    'accessTags': [
      "PreMed-Guides",
      "MDCAT-Guides",
      "AKU-Guides",
      "NUMS-Guides",
      "PreEng-Guides",
      "ECAT-Guides",
      "NUST-Guides",
      "FAST-Guides"
    ]
  },
  {
    'name': 'Cheatsheets',
    'accessTags': [
      "PreMed-Cheatsheets",
      "MDCAT-Cheatsheets",
      "AKU-Cheatsheets",
      "NUMS-Cheatsheets"
    ]
  },
  {
    'name': 'Shortlistings',
    'accessTags': [
      "PreMed-Shortlistings",
      "MDCAT-Shortlistings",
      "AKU-Shortlistings",
      "NUMS-Shortlistings"
    ]
  },
  {
    'name': 'Mnemonics',
    'accessTags': [
      "PreMed-Mnemonics",
      "MDCAT-Mnemonics",
      "AKU-Mnemonics",
      "NUMS-Mnemonics"
    ]
  },
  {
    'name': 'SnapCourses',
    'accessTags': [
      "PreMed-SnapCourses",
      "MDCAT-SnapCourses",
      "AKU-SnapCourses",
      "NUMS-SnapCourses"
    ]
  },
  {
    'name': 'Essentials',
    'accessTags': [
      "PreMed-Essentials",
      "MDCAT-Essentials",
      "AKU-Essentials",
      "NUMS-Essentials"
    ]
  }
];
