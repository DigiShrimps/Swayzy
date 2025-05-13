import 'package:flutter/material.dart';
import 'package:swayzy/constants/app_colors.dart';

import '../../../constants/app_text_styles.dart';

class OrderCardInProcess extends StatelessWidget {
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

  const OrderCardInProcess({
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
    final String orderStatus = "bebra";
    return GestureDetector(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: AppColors.secondaryBackground,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                    image: imageUrl != null ? DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover) : null,
                  ),
                  child: imageUrl == null ? const Icon(Icons.image, size: 50, color: Colors.black54) : null,
                ),
              ),
              const SizedBox(height: 8),
              Text(title, style: AppTextStyles.smallDescription, textAlign: TextAlign.center),
              Text(orderStatus, style: AppTextStyles.orderCategory, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ownerName,
                    style:
                        MediaQuery.of(context).size.width < 400
                            ? AppTextStyles.orderDescription
                            : AppTextStyles.orderCategory,
                  ),
                  Text(
                    createdAt,
                    style:
                        MediaQuery.of(context).size.width < 400
                            ? AppTextStyles.orderDescription
                            : AppTextStyles.orderCategory,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
