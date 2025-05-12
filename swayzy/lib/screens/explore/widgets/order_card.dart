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
  final String ownerId;

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
    required this.ownerId,
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
          ),
        );
      },
      child: Card(
        color: AppColors.secondaryBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 2,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 180,
            maxHeight: MediaQuery.of(context).size.height * 0.26,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width < 370 ? 70 : 90,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.image, size: 40, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                Expanded(child: Text(ownerName, style: AppTextStyles.orderCategory)),
                Expanded(child: Text(title, style: AppTextStyles.smallDescription)),
                Expanded(child: Text(category, style: AppTextStyles.orderCategory)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text("$price", style: AppTextStyles.orderCategory, overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        createdAt,
                        style: AppTextStyles.orderCategory,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
