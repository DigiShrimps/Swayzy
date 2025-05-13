import 'package:flutter/material.dart';
import 'package:swayzy/constants/app_spaces.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

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
  final dynamic adImageUrl;

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
    required this.adImageUrl,
  });
}

class Ad extends StatefulWidget {
  final AdArguments arguments;
  const Ad({super.key, required this.arguments});

  @override
  State<Ad> createState() => _AdState();
}

class _AdState extends State<Ad> {

  @override
  Widget build(BuildContext context) {
    final args = widget.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Advertisement"),
        titleTextStyle: AppTextStyles.title,
        backgroundColor: AppColors.secondaryBackground,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: AppSpacing.large),
        child: Column(
          spacing: AppSpacing.medium,
          children: [
            SizedBox(height: 0),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                  image:
                  args.adImageUrl != null
                      ? DecorationImage(image: NetworkImage(args.adImageUrl), fit: BoxFit.contain)
                      : null,
                ),
                child:
                args.adImageUrl == null
                    ? const Icon(Icons.image, size: 50, color: Colors.black54)
                    : null,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppSpacing.small,
              children: [
                Text(
                  args.adTitle,
                  style: AppTextStyles.title,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Category: ${args.adCategory}",
                  style: AppTextStyles.title,
                  textAlign: TextAlign.start,
                ),
                Text(
                  "Price: ${args.adPrice.toString()} SOL",
                  style: AppTextStyles.title,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Review type: ${args.adReviewType}",
                  style: AppTextStyles.title,
                  textAlign: TextAlign.start,
                ),
                Text(
                  "Duration: ${args.adDuration}",
                  style: AppTextStyles.title,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 20,
                  child: Text(
                    args.adDescription,
                    style: AppTextStyles.body,
                    textAlign: TextAlign.start,
                  ),
                ),
                Text(
                  args.adOwnerName,
                  style: AppTextStyles.smallDescription,
                  textAlign: TextAlign.end,
                ),
                Text(
                  args.adOwnerEmail,
                  style: AppTextStyles.smallDescription,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
