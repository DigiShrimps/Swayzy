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
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppSpacing.medium,
        children: [
          Text(
            args.adCreatedTime,
            style: AppTextStyles.smallDescription,
            textAlign: TextAlign.start,
          ),
          Text(
            args.adTitle,
            style: AppTextStyles.title,
            textAlign: TextAlign.center,
          ),
          Text(
            "${args.adPrice.toString()} SOL",
            style: AppTextStyles.title,
            textAlign: TextAlign.center,
          ),
          Row(
            spacing: AppSpacing.small,
            children: [
              Text(
                args.adCategory,
                style: AppTextStyles.title,
                textAlign: TextAlign.start,
              ),
              Text(
                args.adReviewType,
                style: AppTextStyles.title,
                textAlign: TextAlign.start,
              ),
              Text(
                args.adDuration,
                style: AppTextStyles.title,
                textAlign: TextAlign.start,
              ),
            ],
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
            style: AppTextStyles.body,
            textAlign: TextAlign.end,
          ),
          Text(
            args.adOwnerEmail,
            style: AppTextStyles.body,
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
