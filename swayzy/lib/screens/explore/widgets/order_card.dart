import 'package:flutter/material.dart';
import 'package:swayzy/constants/app_colors.dart';

import '../../../constants/app_text_styles.dart';
import '../../ad/ad.dart';

class OrderCard extends StatelessWidget {
  final String ownerName;
  final dynamic imageUrl;
  final double price;
  final String title;
  final String createdAt;
  final String category;
  final String duration;
  final String ownerEmail;
  final String description;
  final String reviewType;
  final String social;
  final String subscribers;
  final String ownerId;
  final String adId;

  const OrderCard({
    super.key,
    required this.ownerName,
    required this.imageUrl,
    required this.price,
    required this.title,
    required this.createdAt,
    required this.category,
    required this.duration,
    required this.ownerEmail,
    required this.description,
    required this.reviewType,
    required this.social,
    required this.subscribers,
    required this.ownerId,
    required this.adId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/ad',
          arguments: AdArguments(
            adTitle: title,
            adCategory: category,
            adReviewType: reviewType,
            adDescription: description,
            adCreatedTime: createdAt,
            adOwnerId: ownerId,
            adOwnerName: ownerName,
            adOwnerEmail: ownerEmail,
            adPrice: price,
            adDuration: duration,
            adSocial: social,
            adSubscribers: subscribers,
            adImageUrl: imageUrl,
            adId: adId,
          ),
        );
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: AppColors.secondaryBackground,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 10,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                    image:
                      imageUrl != null
                        ? DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.fitWidth,
                        )
                        : null,
                  ),
                  child:
                    imageUrl == null
                      ? const Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.black54,
                      )
                      : null,
                ),
              ),
              const SizedBox(height: 8),
              Flexible(
                flex: 1,
                child: Center(
                  child: Text(ownerName, style: AppTextStyles.orderDescription),
                ),
              ),
              Flexible(
                flex: 3,
                child: Center(
                  child: Text(
                    title,
                    style: AppTextStyles.orderTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Center(
                  child: Text("$price SOL", style: AppTextStyles.orderTitle),
                ),
              ),
              Flexible(
                flex: 1,
                child: Center(
                  child: Text(category, style: AppTextStyles.orderDescription),
                ),
              ),
              Flexible(
                flex: 1,
                child: Center(
                  child: Text(
                    createdAt,
                    style: AppTextStyles.orderDescription,
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text("$price", style: AppTextStyles.orderCategory),
              //     Text(createdAt, style: AppTextStyles.orderCategory, textAlign: TextAlign.right),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
