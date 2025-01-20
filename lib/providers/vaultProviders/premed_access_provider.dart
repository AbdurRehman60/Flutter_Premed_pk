
import '../../constants/constants_export.dart';
import '../../models/subscription_model.dart';

class PreMedAccessProvider with ChangeNotifier {
  List<Subscription> _subscriptions = [];

  void setSubscriptions(List<dynamic> subscriptions) {

    _subscriptions = subscriptions.map((e) => Subscription.fromJson(e)).toList();
    checkAccess(); // Check access whenever subscriptions are updated
  }

  bool _hasGuides = false;
  bool get hasGuides => _hasGuides;

  bool _hasNotes = false;
  bool get hasNotes => _hasNotes;

  bool _hasCheatsheets = false;
  bool get hasCheatsheets => _hasCheatsheets;

  bool _hasShortListings = false;
  bool get hasShortListings => _hasShortListings;

  bool _hasMnemonics = false;
  bool get hasMnemonics => _hasMnemonics;

  bool _hasSnapCourses = false;
  bool get hasSnapCourses => _hasSnapCourses;

  bool _hasEssentials = false;
  bool get hasEssentials => _hasEssentials;

  Future<void> checkAccess() async {
    // Initialize all flags to false
    _hasGuides = false;
    _hasNotes = false;
    _hasCheatsheets = false;
    _hasShortListings = false;
    _hasMnemonics = false;
    _hasSnapCourses = false;
    _hasEssentials = false;

    print('Checking access based on subscriptions...');

    for (final feature in featuresAccess) {
      final featureName = feature['name']! as String;
      final accessTags = feature['accessTags']! as List<String>;

      bool featureAccessGranted = false;

      for (final subscription in _subscriptions) {
        if (accessTags.any((tag) => tag == subscription.name)) {
          featureAccessGranted = true;
          break;
        }
      }

      if (featureAccessGranted) {
        print('Access granted for feature: $featureName');
        switch (featureName) {
          case 'Notes':
            _hasNotes = true;
          case 'Guides':
            _hasGuides = true;
          case 'Cheatsheets':
            _hasCheatsheets = true;
          case 'Shortlistings':
            _hasShortListings = true;
          case 'Mnemonics':
            _hasMnemonics = true;
          case 'SnapCourses':
            _hasSnapCourses = true;
          case 'Essentials':
            _hasEssentials = true;
        }
      } else {
        print('Access denied for feature: $featureName');
      }
    }

    notifyListeners();
    print('Access check complete. Flags updated.');
  }
}
