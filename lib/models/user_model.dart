class User {
  String status;
  bool isLoggedin;
  String userName;
  String fullName;
  String phoneNumber;
  String city;
  String school;
  bool academyJoined;
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
  String accountStatus;
  String subscriptionStatus;
  String subscriptionStartDate;
  String subscriptionEndDate;
  bool freeUser;
  bool purchaseMocks;
  List<String> addonsPurchased;
  String referral;
  List<dynamic> milestones;
  List<dynamic> notificationsRead;
  Map<String, dynamic> otherInfo;
  bool isAdmin;
  BundlesPurchased bundlesPurchased;
  int coins;
  FreeTrial freeTrial;

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
    required this.accountStatus,
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
    required this.isAdmin,
    required this.bundlesPurchased,
    required this.coins,
    required this.freeTrial,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      status: responseData['status'],
      isLoggedin: responseData['isloggedin'],
      userName: responseData['username'],
      fullName: responseData['fullname'],
      phoneNumber: responseData['phonenumber'],
      city: responseData['city'],
      school: responseData['school'],
      academyJoined: responseData['academyJoined'],
      onBoarding: responseData['onboarding'],
      optionalOnboarding: responseData['optionalOnboarding'],
      accountType: responseData['accountType'],
      intendFor: List<String>.from(responseData['intendFor'] ?? []),
      whichYear: responseData['whichYear'],
      country: responseData['country'],
      availableOnWhatsapp: responseData['availableOnWhatsapp'],
      parentFullname: responseData['parentFullname'],
      parentContactNumber: responseData['parentContactNumber'],
      whatsappNumber: responseData['whatsappNumber'],
      accountCreateDate: responseData['accountCreateDate'],
      accountStatus: responseData['accountStatus'],
      subscriptionStatus: responseData['subscriptionStatus'],
      subscriptionStartDate: responseData['subscriptionStartDate'],
      subscriptionEndDate: responseData['subscriptionEndDate'],
      freeUser: responseData['freeUser'],
      purchaseMocks: responseData['purchaseMocks'],
      addonsPurchased: List<String>.from(responseData['addonsPurchased'] ?? []),
      referral: responseData['referral'],
      milestones: List<dynamic>.from(responseData['milestones'] ?? []),
      notificationsRead:
          List<dynamic>.from(responseData['notificationsRead'] ?? []),
      otherInfo: responseData['otherInfo'] ?? {},
      isAdmin: responseData['isAdmin'],
      bundlesPurchased:
          BundlesPurchased.fromJson(responseData['BundlesPurchased']),
      coins: responseData['coins'],
      freeTrial: FreeTrial.fromJson(responseData['freeTrial']),
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['isloggedin'] = isLoggedin;
    _data['username'] = userName;
    _data['fullname'] = fullName;
    _data['phonenumber'] = phoneNumber;
    _data['city'] = city;
    _data['school'] = school;
    _data['academyJoined'] = academyJoined;
    _data['onboarding'] = onBoarding;
    _data['optionalOnboarding'] = optionalOnboarding;
    _data['accountType'] = accountType;
    _data['intendFor'] = intendFor;
    _data['whichYear'] = whichYear;
    _data['country'] = country;
    _data['availableOnWhatsapp'] = availableOnWhatsapp;
    _data['parentFullname'] = parentFullname;
    _data['parentContactNumber'] = parentContactNumber;
    _data['whatsappNumber'] = whatsappNumber;
    _data['accountCreateDate'] = accountCreateDate;
    _data['accountStatus'] = accountStatus;
    _data['subscriptionStatus'] = subscriptionStatus;
    _data['subscriptionStartDate'] = subscriptionStartDate;
    _data['subscriptionEndDate'] = subscriptionEndDate;
    _data['freeUser'] = freeUser;
    _data['purchaseMocks'] = purchaseMocks;
    _data['addonsPurchased'] = addonsPurchased;
    _data['referral'] = referral;
    _data['milestones'] = milestones;
    _data['notificationsRead'] = notificationsRead;
    _data['otherInfo'] = otherInfo;
    _data['isAdmin'] = isAdmin;
    _data['bundlesPurchased'] = bundlesPurchased.toJson();
    _data['coins'] = coins;
    _data['freeTrial'] = freeTrial.toJson();

    return _data;
  }
}

class BundlesPurchased {
  List<BundleItem> bundleItems;
  List<String> tags;

  BundlesPurchased({
    required this.bundleItems,
    required this.tags,
  });

  factory BundlesPurchased.fromJson(Map<String, dynamic> responseData) {
    final List<BundleItem> bundleItems = List<BundleItem>.from(
      responseData.values.map((value) => BundleItem.fromJson(value)),
    );

    final List<String> tags = List<String>.from(responseData['tags'] ?? []);

    return BundlesPurchased(
      bundleItems: bundleItems,
      tags: tags,
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['tags'] = tags;

    for (int i = 0; i < bundleItems.length; i++) {
      _data[i.toString()] = bundleItems[i].toJson();
    }

    return _data;
  }
}

class BundleItem {
  BundleDetails bundleDetails;
  String bundleId;
  String purchaseDate;
  String expiryDate;

  BundleItem({
    required this.bundleDetails,
    required this.bundleId,
    required this.purchaseDate,
    required this.expiryDate,
  });

  factory BundleItem.fromJson(Map<String, dynamic> responseData) {
    return BundleItem(
      bundleDetails: BundleDetails.fromJson(responseData['bundleDetails']),
      bundleId: responseData['bundleId'],
      purchaseDate: responseData['PurchaseDate'],
      expiryDate: responseData['ExpiryDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['bundleDetails'] = bundleDetails.toJson();
    _data['bundleId'] = bundleId;
    _data['PurchaseDate'] = purchaseDate;
    _data['ExpiryDate'] = expiryDate;
    return _data;
  }
}

class BundleDetails {
  String id;
  List<String> bundlePoints;
  List<String> includedTags;
  bool isPublished;
  String bundleName;
  double bundlePrice;
  double discountPercentage;
  String bundleDescription;
  String bundleIcon;
  double bundleDiscount;
  String createdAt;
  String updatedAt;
  int v;
  int position;

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
    required this.v,
    required this.position,
  });

  factory BundleDetails.fromJson(Map<String, dynamic> responseData) {
    return BundleDetails(
      id: responseData['_id'],
      bundlePoints: List<String>.from(responseData['BundlePoints'] ?? []),
      includedTags: List<String>.from(responseData['IncludedTags'] ?? []),
      isPublished: responseData['isPublished'],
      bundleName: responseData['BundleName'],
      bundlePrice: responseData['BundlePrice'],
      discountPercentage: responseData['discountPercentage'],
      bundleDescription: responseData['BundleDescription'],
      bundleIcon: responseData['BundleIcon'],
      bundleDiscount: responseData['BundleDiscount'],
      createdAt: responseData['createdAt'],
      updatedAt: responseData['updatedAt'],
      v: responseData['__v'],
      position: responseData['Position'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['BundlePoints'] = bundlePoints;
    _data['IncludedTags'] = includedTags;
    _data['isPublished'] = isPublished;
    _data['BundleName'] = bundleName;
    _data['BundlePrice'] = bundlePrice;
    _data['discountPercentage'] = discountPercentage;
    _data['BundleDescription'] = bundleDescription;
    _data['BundleIcon'] = bundleIcon;
    _data['BundleDiscount'] = bundleDiscount;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = v;
    _data['Position'] = position;
    return _data;
  }
}

class FreeTrial {
  bool complete;
  int daysLeft;

  FreeTrial({
    required this.complete,
    required this.daysLeft,
  });

  factory FreeTrial.fromJson(Map<String, dynamic> responseData) {
    return FreeTrial(
      complete: responseData['complete'],
      daysLeft: responseData['daysLeft'],
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['complete'] = complete;
    _data['daysLeft'] = daysLeft;
    return _data;
  }
}
