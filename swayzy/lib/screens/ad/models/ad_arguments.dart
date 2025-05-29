class AdArguments {
  final String adTitle;
  final String adCategory;
  final String adReviewType;
  final String adDescription;
  final String adCreatedTime;
  final String adOwnerId;
  final String adOwnerName;
  final String adOwnerEmail;
  final double adPrice;
  final String adDuration;
  final String adSocial;
  final String adSubscribers;
  final dynamic adId;
  final dynamic adImageUrl;
  dynamic processId;
  dynamic userAdStatus;

  AdArguments({
    required this.adTitle,
    required this.adCategory,
    required this.adReviewType,
    required this.adDescription,
    required this.adCreatedTime,
    required this.adOwnerId,
    required this.adOwnerName,
    required this.adOwnerEmail,
    required this.adPrice,
    required this.adDuration,
    required this.adSocial,
    required this.adSubscribers,
    required this.adImageUrl,
    required this.adId,
    this.processId,
    this.userAdStatus,
  });
}