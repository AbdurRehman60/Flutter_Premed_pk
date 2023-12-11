// ignore_for_file: deprecated_member_use

import 'package:premedpk_mobile_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('status', user.status);
    prefs.setBool('isLoggedin', user.isLoggedin);
    prefs.setString('userName', user.userName);
    prefs.setString('fullName', user.fullName);
    prefs.setString('phoneNumber', user.phoneNumber);
    prefs.setString('city', user.city);
    prefs.setString('school', user.school);
    prefs.setString('academyJoined', user.academyJoined);
    prefs.setBool('onBoarding', user.onBoarding);
    prefs.setBool('optionalOnboarding', user.optionalOnboarding);
    prefs.setString('accountType', user.accountType);
    prefs.setStringList('intendFor', List<String>.from(user.intendFor));
    prefs.setString('whichYear', user.whichYear);
    prefs.setString('country', user.country);
    prefs.setBool('availableOnWhatsapp', user.availableOnWhatsapp);
    prefs.setString('parentFullname', user.parentFullname);
    prefs.setString('parentContactNumber', user.parentContactNumber);
    prefs.setString('whatsappNumber', user.whatsappNumber);
    prefs.setString('accountCreateDate', user.accountCreateDate);
    prefs.setString('accountStatus', user.accountStatus ?? "");
    prefs.setString('subscriptionStatus', user.subscriptionStatus);
    prefs.setString('subscriptionStartDate', user.subscriptionStartDate);
    prefs.setString('subscriptionEndDate', user.subscriptionEndDate);
    prefs.setBool('freeUser', user.freeUser ?? false);
    prefs.setBool('purchaseMocks', user.purchaseMocks);
    prefs.setStringList('addonsPurchased', user.addonsPurchased);
    prefs.setString('referral', user.referral);
    prefs.setStringList('milestones', List<String>.from(user.milestones));
    prefs.setStringList(
        'notificationsRead', List<String>.from(user.notificationsRead));

    // prefs.setStringList('tags', user.bundlesPurchased.tags);

    // for (int i = 0; i < user.bundlesPurchased.bundleItems.length; i++) {
    //   BundleItem bundleItem = user.bundlesPurchased.bundleItems[i];
    //   prefs.setString('$i.bundleId', bundleItem.bundleId);
    //   prefs.setString('$i.purchaseDate', bundleItem.purchaseDate);
    //   prefs.setString('$i.expiryDate', bundleItem.expiryDate);

    //   BundleDetails bundleDetails = bundleItem.bundleDetails;
    //   prefs.setString('$i.bundleDetails.id', bundleDetails.id);
    //   prefs.setStringList(
    //       '$i.bundleDetails.bundlePoints', bundleDetails.bundlePoints);
    //   prefs.setStringList(
    //       '$i.bundleDetails.includedTags', bundleDetails.includedTags);
    //   prefs.setBool('$i.bundleDetails.isPublished', bundleDetails.isPublished);
    //   prefs.setString('$i.bundleDetails.bundleName', bundleDetails.bundleName);
    //   prefs.setInt('$i.bundleDetails.bundlePrice', bundleDetails.bundlePrice);
    //   prefs.setDouble('$i.bundleDetails.discountPercentage',
    //       bundleDetails.discountPercentage);
    //   prefs.setString('$i.bundleDetails.bundleDescription',
    //       bundleDetails.bundleDescription);
    //   prefs.setString('$i.bundleDetails.bundleIcon', bundleDetails.bundleIcon);
    //   prefs.setInt(
    //       '$i.bundleDetails.bundleDiscount', bundleDetails.bundleDiscount);
    //   prefs.setString('$i.bundleDetails.createdAt', bundleDetails.createdAt);
    //   prefs.setString('$i.bundleDetails.updatedAt', bundleDetails.updatedAt);
    // }

    // Save FreeTrial
    prefs.setBool('freeTrial.complete', user.freeTrial.complete);
    prefs.setInt('freeTrial.daysLeft', user.freeTrial.daysLeft);

    return prefs.commit();
  }

  Future<bool> saveNewUser(bool? onBoarding) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('status', 'User is logged in');
    prefs.setBool('isLoggedin', true);
    prefs.setBool('onBoarding', onBoarding ?? false);
    return prefs.commit();
  }
  // Future<void> initNetworkCheck() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('netwrokChecked', true);
  // }

  // Future<User?> getUser() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   final String? status = prefs.getString('status') ;
  //   final bool? isLoggedin = prefs.getBool('isLoggedin');
  //   final String? userName = prefs.getString('userName');
  //   final String? fullName = prefs.getString('fullName');
  //   final String? phoneNumber = prefs.getString('phoneNumber');
  //   final String? city = prefs.getString('city');
  //   final String? school = prefs.getString('school');
  //   final String? academyJoined = prefs.getString('academyJoined');
  //   final bool? onBoarding = prefs.getBool('onBoarding');
  //   final bool? optionalOnboarding = prefs.getBool('optionalOnboarding');
  //   final String? accountType = prefs.getString('accountType');
  //   final List<String>? intendFor = prefs.getStringList('intendFor');
  //   final String? whichYear = prefs.getString('whichYear');
  //   final String? country = prefs.getString('country');
  //   final bool? availableOnWhatsapp = prefs.getBool('availableOnWhatsapp');
  //   final String? parentFullname = prefs.getString('parentFullname');
  //   final String? parentContactNumber = prefs.getString('parentContactNumber');
  //   final String? whatsappNumber = prefs.getString('whatsappNumber');
  //   final String? accountCreateDate = prefs.getString('accountCreateDate');
  //   final String? accountStatus = prefs.getString('accountStatus');
  //   final String? subscriptionStatus = prefs.getString('subscriptionStatus');
  //   final String? subscriptionStartDate =
  //       prefs.getString('subscriptionStartDate');
  //   final String? subscriptionEndDate = prefs.getString('subscriptionEndDate');
  //   final bool? freeUser = prefs.getBool('freeUser');
  //   final bool? purchaseMocks = prefs.getBool('purchaseMocks');
  //   final List<String>? addonsPurchased =
  //       prefs.getStringList('addonsPurchased');
  //   final String? referral = prefs.getString('referral');
  //   final List<String>? milestones = prefs.getStringList('milestones');
  //   final List<String>? notificationsRead =
  //       prefs.getStringList('notificationsRead');

  //   // Retrieve BundlesPurchased
  //   final List<String>? tags = prefs.getStringList('tags');
  //   final List<BundleItem> bundleItems = [];

  //   for (int i = 0; prefs.containsKey('$i.bundleId'); i++) {
  //     final String? bundleId = prefs.getString('$i.bundleId');
  //     final String? purchaseDate = prefs.getString('$i.purchaseDate');
  //     final String? expiryDate = prefs.getString('$i.expiryDate');

  //     // Retrieve BundleDetails
  //     final BundleDetails bundleDetails = BundleDetails(
  //       id: prefs.getString('$i.bundleDetails.id') ?? '',
  //       bundlePoints:
  //           prefs.getStringList('$i.bundleDetails.bundlePoints') ?? [],
  //       includedTags:
  //           prefs.getStringList('$i.bundleDetails.includedTags') ?? [],
  //       isPublished: prefs.getBool('$i.bundleDetails.isPublished') ?? false,
  //       bundleName: prefs.getString('$i.bundleDetails.bundleName') ?? '',
  //       bundlePrice: prefs.getInt('$i.bundleDetails.bundlePrice') ?? 0,
  //       discountPercentage:
  //           prefs.getDouble('$i.bundleDetails.discountPercentage') ?? 0.0,
  //       bundleDescription:
  //           prefs.getString('$i.bundleDetails.bundleDescription') ?? '',
  //       bundleIcon: prefs.getString('$i.bundleDetails.bundleIcon') ?? '',
  //       bundleDiscount: prefs.getInt('$i.bundleDetails.bundleDiscount') ?? 0,
  //       createdAt: prefs.getString('$i.bundleDetails.createdAt') ?? '',
  //       updatedAt: prefs.getString('$i.bundleDetails.updatedAt') ?? '',
  //     );

  //     final BundleItem bundleItem = BundleItem(
  //       bundleDetails: bundleDetails,
  //       bundleId: bundleId ?? '',
  //       purchaseDate: purchaseDate ?? '',
  //       expiryDate: expiryDate ?? '',
  //     );

  //     bundleItems.add(bundleItem);
  //   }

  //   // Retrieve FreeTrial
  //   final bool? freeTrialComplete = prefs.getBool('freeTrial.complete');
  //   final int? freeTrialDaysLeft = prefs.getInt('freeTrial.daysLeft');

  //   return User(
  //     status: status,
  //     isLoggedin: isLoggedin,
  //     userName: userName,
  //     fullName: fullName,
  //     phoneNumber: phoneNumber,
  //     city: city,
  //     school: school,
  //     academyJoined: academyJoined,
  //     onBoarding: onBoarding,
  //     optionalOnboarding: optionalOnboarding,
  //     accountType: accountType,
  //     intendFor: intendFor,
  //     whichYear: whichYear,
  //     country: country,
  //     availableOnWhatsapp: availableOnWhatsapp,
  //     parentFullname: parentFullname,
  //     parentContactNumber: parentContactNumber,
  //     whatsappNumber: whatsappNumber,
  //     accountCreateDate: accountCreateDate,
  //     accountStatus: accountStatus,
  //     subscriptionStatus: subscriptionStatus,
  //     subscriptionStartDate: subscriptionStartDate,
  //     subscriptionEndDate: subscriptionEndDate,
  //     freeUser: freeUser,
  //     purchaseMocks: purchaseMocks,
  //     addonsPurchased: addonsPurchased,
  //     referral: referral,
  //     milestones: milestones,
  //     notificationsRead: notificationsRead,
  //     // bundlesPurchased:
  //     //     BundlesPurchased(bundleItems: bundleItems, tags: tags),
  //     coins: 0, // Add the appropriate default value or retrieve it from prefs
  //     freeTrial:
  //         FreeTrial(complete: freeTrialComplete, daysLeft: freeTrialDaysLeft),
  //     otherInfo: {},
  //   );
  // }

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
