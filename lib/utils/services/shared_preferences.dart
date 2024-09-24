// ignore_for_file: deprecated_member_use

import 'package:premedpk_mobile_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  final String _fcmTokenKey = 'fcmToken';

  Future<void> saveFcmToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fcmTokenKey, token);
  }

  Future<String?> getFcmToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_fcmTokenKey);
  }

  Future<void> deleteFcmToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_fcmTokenKey);
  }

  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('status', user.status);
    prefs.setBool('isLoggedin', user.isLoggedin);
    prefs.setString('userName', user.userName);
    prefs.setString('fullName', user.fullName);
    prefs.setString('phoneNumber', user.phoneNumber);
    prefs.setString('city', user.city);
    prefs.setString('school', user.school);
    //prefs.setString('accountType', user.accountType);
    prefs.setString('country', user.country);
    prefs.setBool('availableOnWhatsapp', user.availableOnWhatsapp);
    prefs.setString('parentFullname', user.parentFullName);
    prefs.setString('parentContactNumber', user.parentContactNumber);
    prefs.setString('whatsappNumber', user.whatsappNumber);
    prefs.setString('accountCreateDate', user.accountCreateDate);
    prefs.setStringList('milestones', List<String>.from(user.milestones));
    prefs.setStringList(
        'notificationsRead', List<String>.from(user.notificationsRead));

    return prefs.commit();
  }

  Future<bool> saveNewUser(bool? onBoarding) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('status', 'User is logged in');
    prefs.setBool('isLoggedin', true);
    prefs.setBool('onBoarding', onBoarding ?? false);
    return prefs.commit();
  }




  Future<void> logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('status');
    prefs.remove('isLoggedin');
    prefs.remove('userName');
    prefs.remove('fullName');
    prefs.remove('phoneNumber');
    prefs.remove('city');
    prefs.remove('school');
    prefs.remove('academyJoined');
    prefs.remove('onBoarding');
    prefs.remove('optionalOnboarding');
    prefs.remove('accountType');
    prefs.remove('intendFor');
    prefs.remove('whichYear');
    prefs.remove('country');
    prefs.remove('availableOnWhatsapp');
    prefs.remove('parentFullname');
    prefs.remove('parentContactNumber');
    prefs.remove('whatsappNumber');
    prefs.remove('accountCreateDate');
    prefs.remove('accountStatus');
    prefs.remove('subscriptionStatus');
    prefs.remove('subscriptionStartDate');
    prefs.remove('subscriptionEndDate');
    prefs.remove('freeUser');
    prefs.remove('purchaseMocks');
    prefs.remove('addonsPurchased');
    prefs.remove('referral');
    prefs.remove('milestones');
    prefs.remove('notificationsRead');
    prefs.remove('cookies');
    prefs.remove('tags');
    for (int i = 0; prefs.containsKey('$i.bundleId'); i++) {
      prefs.remove('$i.bundleId');
      prefs.remove('$i.purchaseDate');
      prefs.remove('$i.expiryDate');

      prefs.remove('$i.bundleDetails.id');
      prefs.remove('$i.bundleDetails.bundlePoints');
      prefs.remove('$i.bundleDetails.includedTags');
      prefs.remove('$i.bundleDetails.isPublished');
      prefs.remove('$i.bundleDetails.bundleName');
      prefs.remove('$i.bundleDetails.bundlePrice');
      prefs.remove('$i.bundleDetails.discountPercentage');
      prefs.remove('$i.bundleDetails.bundleDescription');
      prefs.remove('$i.bundleDetails.bundleIcon');
      prefs.remove('$i.bundleDetails.bundleDiscount');
      prefs.remove('$i.bundleDetails.createdAt');
      prefs.remove('$i.bundleDetails.updatedAt');
      prefs.remove('$i.bundleDetails.v');
      prefs.remove('$i.bundleDetails.position');
    }

    prefs.remove('freeTrial.complete');
    prefs.remove('freeTrial.daysLeft');
  }

}
