import 'dart:convert';
// Info class
class Info {
  Info({
    required this.features,
    required this.exam,
    required this.lastOnboardingPage,
    required this.approach,
    required this.year,
    required this.educationSystem,
    required this.institution
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      features: List<dynamic>.from(json['features'] ?? []),
      exam: List<dynamic>.from(json['exam'] ?? []),
      lastOnboardingPage: json['lastOnboardingPage'] ?? '',
      institution: json['institution']??'',
      year: json['year']??'',
      educationSystem: json['educationSystem']??'',
      approach: json['approach']??'',
    );
  }

  List<dynamic> features;
  List<dynamic> exam;
  String lastOnboardingPage;
  String institution;
  String year;
  String educationSystem;
  String approach;

  Map<String, dynamic> toJson() {
    return {
      'features': features,
      'exam': exam,
      'lastOnboardingPage': lastOnboardingPage,
      'year':year,
      'educationSystem': educationSystem,
      'institution': institution,
      'approach': approach
    };
  }
}

// User class
class User {
  User({
    required this.userId,
    required this.status,
    required this.isLoggedin,
    required this.userName,
    required this.fullName,
    required this.phoneNumber,
    required this.city,
    required this.school,
    required this.accountType,
    required this.country,
    required this.availableOnWhatsapp,
    required this.parentFullName,
    required this.parentContactNumber,
    required this.whatsappNumber,
    required this.accountCreateDate,
    required this.isAdmin,
    required this.milestones,
    required this.notificationsRead,
    required this.subscriptions,
    required this.info,
    required this.purposeOfUsage,
    required this.featuresPurchased,
    required this.access,
    required this.coins,
    required this.otherInfo,
    required this.bundlesPurchased,
    required this.educationSystem,
    required this.year,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      userId: responseData['id'] ?? '',
      status: responseData['status'] ?? '',
      isLoggedin: responseData['isloggedin'] ?? false,
      userName: responseData['username'] ?? '',
      fullName: responseData['fullname'] ?? '',
      phoneNumber: responseData['phonenumber'] ?? '',
      city: responseData['city'] ?? '',
      school: responseData['school'] ?? '',
      country: responseData['country'] ?? '',
      accountType: responseData['accountType'] ?? '',
      availableOnWhatsapp: responseData['availableOnWhatsapp'] ?? false,
      parentFullName: responseData['parentFullName'] ?? '',
      parentContactNumber: responseData['parentContactNumber'] ?? '',
      whatsappNumber: responseData['whatsappNumber'] ?? '',
      accountCreateDate: responseData['accountcreateddate'] ?? '',
      isAdmin: responseData['isadmin'] ?? false,
      milestones: List<dynamic>.from(responseData['milestones'] ?? []),
      notificationsRead: List<dynamic>.from(responseData['notificationsread'] ?? []),
      subscriptions: List<dynamic>.from(responseData['subscriptions'] ?? []),
      info: Info.fromJson(responseData['info'] ?? {}),
      purposeOfUsage: List<dynamic>.from(responseData['purposeOfUsage'] ?? []),
      featuresPurchased: List<dynamic>.from(responseData['featuresPurchased'] ?? []),
      access: List<dynamic>.from(responseData['access'] ?? []),
      coins: responseData['coins'] ?? 0,
      otherInfo: responseData['otherinfo'] ?? {},
      bundlesPurchased: responseData['BundlesPurchased'] != null
          ? json.encode(responseData['BundlesPurchased'])
          : '',
      educationSystem: responseData['educationSystem'] ?? '',
      year: responseData['year'] ?? '',
    );
  }

  String userId;
  String status;
  bool isLoggedin;
  String userName;
  String fullName;
  String phoneNumber;
  String city;
  String school;
  String country;
  String accountType;
  bool availableOnWhatsapp;
  String parentFullName;
  String parentContactNumber;
  String whatsappNumber;
  String accountCreateDate;
  bool isAdmin;
  List<dynamic> milestones;
  List<dynamic> notificationsRead;
  List<dynamic> subscriptions;
  Info info;
  List<dynamic> purposeOfUsage;
  List<dynamic> featuresPurchased;
  List<dynamic> access;
  int coins;
  Map<String, dynamic> otherInfo;
  String bundlesPurchased;
  String educationSystem;
  String year;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = userId;
    data['status'] = status;
    data['isloggedin'] = isLoggedin;
    data['username'] = userName;
    data['fullname'] = fullName;
    data['phonenumber'] = phoneNumber;
    data['city'] = city;
    data['school'] = school;
    data['country'] = country;
    data['accountType'] = accountType;
    data['availableOnWhatsapp'] = availableOnWhatsapp;
    data['parentFullName'] = parentFullName;
    data['parentContactNumber'] = parentContactNumber;
    data['whatsappNumber'] = whatsappNumber;
    data['accountcreateddate'] = accountCreateDate;
    data['isadmin'] = isAdmin;
    data['milestones'] = milestones;
    data['notificationsread'] = notificationsRead;
    data['subscriptions'] = subscriptions;
    data['info'] = info.toJson();
    data['purposeOfUsage'] = purposeOfUsage;
    data['featuresPurchased'] = featuresPurchased;
    data['access'] = access;
    data['coins'] = coins;
    data['otherinfo'] = otherInfo;
    data['BundlesPurchased'] = bundlesPurchased;
    data['educationSystem'] = educationSystem;
    data['year'] = year;

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
