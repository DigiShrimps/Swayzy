import '../models/review_type.dart';

final List<ReviewType> reviewTypes = [
  ReviewType(key: "positive"),
  ReviewType(key: "fair"),
  ReviewType(key: "negative"),
];

final Map<String, ReviewType> reviewTypesMap = {
  for (var review in reviewTypes) review.key: review
};
