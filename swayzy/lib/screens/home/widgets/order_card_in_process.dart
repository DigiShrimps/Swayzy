import 'package:flutter/material.dart';
import 'package:swayzy/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../constants/app_spaces.dart';
import '../../../constants/app_text_styles.dart';
import '../../../l10n/app_localizations.dart';
import '../../ad/models/ad_arguments.dart';

class OrderCardInProcess extends StatelessWidget {
  final String ownerName;
  final dynamic imageUrl;
  final double price;
  final String title;
  final String createdAt;
  final String category;
  final int duration;
  final String ownerEmail;
  final String description;
  final String reviewType;
  final String social;
  final String subscribers;
  final String ownerId;
  final String orderStatus;
  final String processId;

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
    required this.social,
    required this.subscribers,
    required this.orderStatus,
    required this.processId,
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
            adId: null,
            processId: processId,
            userAdStatus: orderStatus
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
                        imageUrl:
                        imageUrl,
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
                  child: Text(
                    ownerName,
                    style: AppTextStyles.orderDescription,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
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
                child: Text(
                  localizations.statusOption(orderStatus),
                  style: AppTextStyles.orderDescription,
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                flex: 1,
                child: Center(
                  child: Text(
                    createdAt,
                    style: AppTextStyles.orderDescription,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
