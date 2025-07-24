import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:swayzy/constants/app_colors.dart';

import '../../../constants/app_spaces.dart';
import '../../../constants/app_text_styles.dart';
import '../../../l10n/app_localizations.dart';
import '../../ad/models/ad_arguments.dart';

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
    final localizations = AppLocalizations.of(context)!;
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
        color: AppColors.secondaryBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  flex: 3,
                  fit: FlexFit.loose,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.fitWidth,
                        placeholder: (context, url) => const SizedBox(
                            height: 200,
                            child: CircularProgressIndicator(
                              padding:
                              EdgeInsets.all(AppSpacing.small),
                            )
                        ),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                  )
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
                  child: Text("$price Cedra", style: AppTextStyles.orderTitle),
                ),
              ),
              Flexible(
                flex: 1,
                child: Center(
                  child: Text(localizations.categoryOption(category), style: AppTextStyles.orderDescription),
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
            ],
          ),
        ),
      ),
    );
  }
}
