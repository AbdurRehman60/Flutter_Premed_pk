
class User {

  User({
    required this.status,
    required this.isLoggedin,
    required this.userName,
    required this.fullName,
    required this.phoneNumber,
    required this.city,
    required this.school,
    required this.academyJoined,
    required this.onBoarding,
    required this.optionalOnboarding,
    required this.accountType,
    required this.intendFor,
    required this.whichYear,
    required this.country,
    required this.availableOnWhatsapp,
    required this.parentFullname,
    required this.parentContactNumber,
    required this.whatsappNumber,
    required this.accountCreateDate,
    this.accountStatus,
    required this.subscriptionStatus,
    required this.subscriptionStartDate,
    required this.subscriptionEndDate,
    required this.freeUser,
    required this.purchaseMocks,
    required this.addonsPurchased,
    required this.referral,
    required this.milestones,
    required this.notificationsRead,
    required this.otherInfo,
    // required this.bundlesPurchased,
    required this.coins,
    required this.freeTrial,
    required this.feedbackSubmitted,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      status: responseData['status'] ?? "",
      isLoggedin: responseData['isloggedin'] ?? false,
      userName: responseData['username'] ?? "",
      fullName: responseData['fullname'] ?? "",
      phoneNumber: responseData['phonenumber'] ?? "",
      city: responseData['city'] ?? "",
      school: responseData['school'] ?? "",
      academyJoined: responseData['academyJoined'] ?? "",
      onBoarding:
      responseData['onboarding'] == "" ? false : responseData['onboarding'],
      optionalOnboarding: responseData['optionalOnboarding'] == ""
          ? false
          : responseData['optionalOnboarding'],
      accountType: responseData['accountType'] ?? "",
      intendFor: List<String>.from(responseData['intendFor'] ?? []),
      whichYear: responseData['whichYear'] ?? "",
      country: responseData['country'] ?? "",
      availableOnWhatsapp: responseData['availableOnWhatsapp'] == ""
          ? false
          : responseData['availableOnWhatsapp'],
      parentFullname: responseData['parentFullName'] ?? "",
      parentContactNumber: responseData['parentContactNumber'] ?? "",
      whatsappNumber: responseData['whatsappNumber'] ?? "",
      accountCreateDate: responseData['accountcreateddate'] ?? "",
      accountStatus: responseData['accountstatus'] ?? "",
      subscriptionStatus: responseData['subscriptionstatus'] ?? "",
      subscriptionStartDate: responseData['subscriptionstartdate'] ?? "",
      subscriptionEndDate: responseData['subscriptionenddate'] ?? "",
      freeUser:
      responseData['freeuser'] == "" ? false : responseData['freeuser'],
      purchaseMocks: responseData['purchasedmocks'] == ""
          ? false
          : responseData['purchasedmocks'],
      addonsPurchased: List<String>.from(responseData['addonspurchased'] ?? []),
      referral: responseData['referal'] ?? "",
      milestones: List<dynamic>.from(responseData['milestones'] ?? []),
      notificationsRead:
      List<dynamic>.from(responseData['notificationsread'] ?? []),
      otherInfo: responseData['otherinfo'] ?? {},
      // bundlesPurchased:
      //     BundlesPurchased.fromJson(responseData['BundlesPurchased'] ?? {}),
      coins: responseData['coins'] ?? 0,
      freeTrial: responseData['freeTrial'] != null && responseData['freeTrial'] is Map<String, dynamic>
          ? FreeTrial.fromJson(responseData['freeTrial'])
          : FreeTrial(complete: false, daysLeft: 0),
      feedbackSubmitted: responseData['feedbackSubmitted'] ?? false,
    );
  }
  String status;
  bool isLoggedin;
  String userName;
  String fullName;
  String phoneNumber;
  String city;
  String school;
  String academyJoined;
  bool onBoarding;
  bool optionalOnboarding;
  String accountType;
  List<dynamic> intendFor;
  String whichYear;
  String country;
  bool availableOnWhatsapp;
  String parentFullname;
  String parentContactNumber;
  String whatsappNumber;
  String accountCreateDate;
  String? accountStatus;
  String subscriptionStatus;
  String subscriptionStartDate;
  String subscriptionEndDate;
  bool? freeUser;
  bool purchaseMocks;
  List<String> addonsPurchased;
  String referral;
  List<dynamic> milestones;
  List<dynamic> notificationsRead;
  Map<String, dynamic> otherInfo;
  // BundlesPurchased bundlesPurchased;
  int coins;
  FreeTrial freeTrial;
  bool feedbackSubmitted;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['isloggedin'] = isLoggedin;
    data['email'] = userName;
    data['fullname'] = fullName;
    data['phonenumber'] = phoneNumber;
    data['city'] = city;
    data['school'] = school;
    data['academyJoined'] = academyJoined;
    data['onboarding'] = onBoarding;
    data['optionalOnboarding'] = optionalOnboarding;
    data['accountType'] = accountType;
    data['intendFor'] = intendFor;
    data['whichYear'] = whichYear;
    data['country'] = country;
    data['availableOnWhatsapp'] = availableOnWhatsapp;
    data['parentFullname'] = parentFullname;
    data['parentContactNumber'] = parentContactNumber;
    data['whatsappNumber'] = whatsappNumber;
    data['accountCreateDate'] = accountCreateDate;
    data['accountStatus'] = accountStatus;
    data['subscriptionStatus'] = subscriptionStatus;
    data['subscriptionStartDate'] = subscriptionStartDate;
    data['subscriptionEndDate'] = subscriptionEndDate;
    data['freeUser'] = freeUser;
    data['purchasedmocks'] = purchaseMocks;
    data['addonsPurchased'] = addonsPurchased;
    data['referral'] = referral;
    data['milestones'] = milestones;
    data['notificationsRead'] = notificationsRead;
    data['otherInfo'] = otherInfo;
    // _data['bundlesPurchased'] = bundlesPurchased.toJson();
    data['coins'] = coins;
    data['freeTrial'] = freeTrial.toJson();

    return data;
  }
}

class BundlesPurchased {

  BundlesPurchased({
    required this.bundleItems,
    required this.tags,
  });

  factory BundlesPurchased.fromJson(Map<String, dynamic> responseData) {
    final List<BundleItem> bundleItems = List<BundleItem>.from(
      (responseData['tags'] as List<dynamic>).map(
            (value) => BundleItem.fromJson(value as Map<String, dynamic>),
      ),
    );

    final List<String> tags = List<String>.from(responseData['tags'] ?? []);

    return BundlesPurchased(
      bundleItems: bundleItems,
      tags: tags,
    );
  }
  List<BundleItem> bundleItems;
  List<String> tags;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tags'] = tags;

    for (int i = 0; i < bundleItems.length; i++) {
      data[i.toString()] = bundleItems[i].toJson();
    }

    return data;
  }
}

class BundleItem {

  BundleItem({
    required this.bundleDetails,
    required this.bundleId,
    required this.purchaseDate,
    required this.expiryDate,
  });

  factory BundleItem.fromJson(Map<String, dynamic> responseData) {
    return BundleItem(
      bundleDetails: BundleDetails.fromJson(
          responseData['bundleDetails'] as Map<String, dynamic>),
      bundleId: responseData['bundleId'],
      purchaseDate: responseData['PurchaseDate'],
      expiryDate: responseData['ExpiryDate'],
    );
  }
  BundleDetails bundleDetails;
  String bundleId;
  String purchaseDate;
  String expiryDate;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bundleDetails'] = bundleDetails.toJson();
    data['bundleId'] = bundleId;
    data['PurchaseDate'] = purchaseDate;
    data['ExpiryDate'] = expiryDate;
    return data;
  }
}

class BundleDetails {

  BundleDetails({
    required this.id,
    required this.bundlePoints,
    required this.includedTags,
    required this.isPublished,
    required this.bundleName,
    required this.bundlePrice,
    required this.discountPercentage,
    required this.bundleDescription,
    required this.bundleIcon,
    required this.bundleDiscount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BundleDetails.fromJson(Map<String, dynamic> responseData) {
    return BundleDetails(
      id: responseData['_id'],
      bundlePoints: List<String>.from(responseData['BundlePoints'] ?? []),
      includedTags: List<String>.from(responseData['IncludedTags'] ?? []),
      isPublished: responseData['isPublished'],
      bundleName: responseData['BundleName'],
      bundlePrice: responseData['BundlePrice'],
      discountPercentage: responseData['discountPercentage'].toDouble(),
      bundleDescription: responseData['BundleDescription'],
      bundleIcon: responseData['BundleIcon'],
      bundleDiscount: responseData['BundleDiscount'],
      createdAt: responseData['createdAt'],
      updatedAt: responseData['updatedAt'],
    );
  }
  String id;
  List<String> bundlePoints;
  List<String> includedTags;
  bool isPublished;
  String bundleName;
  int bundlePrice;
  double discountPercentage;
  String bundleDescription;
  String bundleIcon;
  int bundleDiscount;
  String createdAt;
  String updatedAt;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['BundlePoints'] = bundlePoints;
    data['IncludedTags'] = includedTags;
    data['isPublished'] = isPublished;
    data['BundleName'] = bundleName;
    data['BundlePrice'] = bundlePrice;
    data['discountPercentage'] = discountPercentage;
    data['BundleDescription'] = bundleDescription;
    data['BundleIcon'] = bundleIcon;
    data['BundleDiscount'] = bundleDiscount;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;

    return data;
  }
}

class FreeTrial {

  FreeTrial({
    required this.complete,
    required this.daysLeft,
  });

  factory FreeTrial.fromJson(Map<String, dynamic>? responseData) {
    return FreeTrial(
      complete: responseData?['complete'] ?? false,
      daysLeft: responseData?['daysLeft'] ?? 0,
    );
  }
  bool complete;
  int daysLeft;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['complete'] = complete;
    data['daysLeft'] = daysLeft;
    return data;
  }
}
