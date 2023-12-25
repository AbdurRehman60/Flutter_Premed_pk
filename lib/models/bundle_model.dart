class BundleModel {
  BundleModel({
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
    required this.position,
    this.bundlePDF,
    this.interestedFormLink,
    this.purchaseFormLink,
  });

  factory BundleModel.fromJson(Map<String, dynamic> json) {
    return BundleModel(
      id: json['_id'],
      bundlePoints: (json['BundlePoints'] as List).cast<String>(),
      includedTags: (json['IncludedTags'] as List).cast<String>(),
      isPublished: json['isPublished'],
      bundleName: json['BundleName'],
      bundlePrice: json['BundlePrice'].toDouble(),
      discountPercentage: json['discountPercentage'].toDouble(),
      bundleDescription: json['BundleDescription'],
      bundleIcon: json['BundleIcon'],
      bundleDiscount: json['BundleDiscount'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      position: json['Position'],
      bundlePDF: json['BundlePDF'],
      interestedFormLink: json['InterestedFormLink'],
      purchaseFormLink: json['PurchaseFormLink'],
    );
  }
  final String id;
  final List<String> bundlePoints;
  final List<String> includedTags;
  final bool isPublished;
  final String bundleName;
  final double bundlePrice;
  final double discountPercentage;
  final String bundleDescription;
  final String bundleIcon;
  final double bundleDiscount;
  final DateTime createdAt;
  final DateTime updatedAt;

  final int position;
  final String? bundlePDF;
  final String? interestedFormLink;
  final String? purchaseFormLink;
}
