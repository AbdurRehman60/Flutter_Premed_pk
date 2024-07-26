
import 'package:flutter/material.dart';

class UserAccessProvider with ChangeNotifier {

  UserAccessProvider(List<Map<String, dynamic>> subscriptions) {
    _subscriptions = subscriptions.map((e) => Subscription.fromJson(e)).toList();
  }
  List<Subscription> _subscriptions = [];

  List<Subscription> get subscriptions => _subscriptions;

  bool get access {
    const featuresAccess = [
      {
        'name': 'Notes',
        'accessTags': ["PreMed-Notes", "MDCAT-Notes", "AKU-Notes", "NUMS-Notes", "PreEng-Notes", "ECAT-Notes", "NUST-Notes", "FAST-Notes"]
      },
      {
        'name': 'Guides',
        'accessTags': ["PreMed-Guides", "MDCAT-Guides", "AKU-Guides", "NUMS-Guides", "PreEng-Guides", "ECAT-Guides", "NUST-Guides", "FAST-Guides"]
      },
      {
        'name': 'Cheatsheets',
        'accessTags': ["PreMed-Cheatsheets", "MDCAT-Cheatsheets", "AKU-Cheatsheets", "NUMS-Cheatsheets"]
      },
      {
        'name': 'Shortlistings',
        'accessTags': ["PreMed-Shortlistings", "MDCAT-Shortlistings", "AKU-Shortlistings", "NUMS-Shortlistings"]
      },
      {
        'name': 'Mnemonics',
        'accessTags': ["PreMed-Mnemonics", "MDCAT-Mnemonics", "AKU-Mnemonics", "NUMS-Mnemonics"]
      },
      {
        'name': 'SnapCourses',
        'accessTags': ["PreMed-SnapCourses", "MDCAT-SnapCourses", "AKU-SnapCourses", "NUMS-SnapCourses"]
      },
      {
        'name': 'Essentials',
        'accessTags': ["PreMed-Essentials", "MDCAT-Essentials", "AKU-Essentials", "NUMS-Essentials"]
      }
    ];

    final currentDate = DateTime.now();
    for (final feature in featuresAccess) {
      final accessTags = feature['accessTags']! as List<String>;
      for (final tag in accessTags) {
        for (final subscription in _subscriptions) {
          if (subscription.name == tag && subscription.subscriptionEndDate.isAfter(currentDate)) {
            return true;
          }
        }
      }
    }
    return false;
  }
}

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
