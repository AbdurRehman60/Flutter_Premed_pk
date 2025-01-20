
import '../../../constants/constants_export.dart';
import '../../../models/subscription_model.dart';

class PreEngAccessProvider with ChangeNotifier {
  List<Subscription> _subscriptions = [];

  void setSubscriptions(List<dynamic> subscriptions) {
    _subscriptions = subscriptions.map((e) => Subscription.fromJson(e)).toList();
    notifyListeners();
  }


  bool _hasEngGuides = false;
  bool get hasEngGuides => _hasEngGuides;
  set hasEngGuides(bool value) {
      _hasEngGuides = value;
      notifyListeners();
  }

  bool _hasEngNotes = false;
  bool get hasEngNotes => _hasEngNotes;
  set hasEngNotes(bool value) {
      _hasEngNotes = value;
      notifyListeners();
  }

  bool _hasEngCheatsheets = false;
  bool get hasEngCheatsheets => _hasEngCheatsheets;
  set hasEngCheatsheets(bool value) {
      _hasEngCheatsheets = value;
      notifyListeners();
  }

  bool _hasEngShortListings = false;
  bool get hasEngShortListings => _hasEngShortListings;
  set hasEngShortListings(bool value) {
      _hasEngShortListings = value;
      notifyListeners();
  }

  bool _hasEngMnemonics = false;
  bool get hasEngMnemonics => _hasEngMnemonics;
  set hasEngMnemonics(bool value) {
      _hasEngMnemonics = value;
      notifyListeners();
  }

  bool _hasEngSnapCourses = false;
  bool get hasEngSnapCourses => _hasEngSnapCourses;
  set hasEngSnapCourses(bool value) {
      _hasEngSnapCourses = value;
      notifyListeners();
  }

  bool _hasEngEssentials = false;
  bool get hasEngEssentials => _hasEngEssentials;
  set hasEngEssentials(bool value) {
      _hasEngEssentials = value;
      notifyListeners();
    }

  void updateAccessFlags() {
    // Initialize all flags to false
    _hasEngGuides = false;
    _hasEngNotes = false;
    _hasEngCheatsheets = false;
    _hasEngShortListings = false;
    _hasEngMnemonics = false;
    _hasEngSnapCourses = false;
    _hasEngEssentials = false;

    for (final feature in featuresAccess) {
      final featureName = feature['name']! as String;
      final accessTags = feature['accessTags']! as List<String>;

      print('Checking feature: $featureName');
      print('Access tags: $accessTags');

      bool accessGranted = false;

      // Check if any subscription's name matches the access tags
      for (final subscription in _subscriptions) {
        print('Checking subscription: ${subscription.name}');
        if (accessTags.any((tag) => tag == subscription.name)) {
          accessGranted = true;
          print('Access granted for: $featureName');
          break;
        }
      }

      switch (featureName) {
        case 'Notes':
          _hasEngNotes = accessGranted;
        case 'Guides':
          _hasEngGuides = accessGranted;
        case 'Cheatsheets':
          _hasEngCheatsheets = accessGranted;
        case 'Shortlistings':
          _hasEngShortListings = accessGranted;
        case 'Mnemonics':
          _hasEngMnemonics = accessGranted;
        case 'SnapCourses':
          _hasEngSnapCourses = accessGranted;
        case 'Essentials':
          _hasEngEssentials = accessGranted;
      }

      if (!accessGranted) {
        print('No access granted for: $featureName');
      }
    }

    notifyListeners();
  }


}
