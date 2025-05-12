import 'package:flutter/material.dart';
import 'package:swayzy/constants/app_spaces.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

class AdArguments{
  late  String adTitle = 'Title'; //TODO додати фінал
  late  String adCategory = 'Category';
  late  String adReviewType = 'Positive';
  late  String adDescription = 'Description';
  late  String adCreatedTime = '12 5 13:30';
  late  String adOwnerId = '123';
  late  String adOwnerName = 'Vitaliy';
  late  String adOwnerEmail = 'yatsiks69@gmail.com';
  late  int adPrice = 10;
  late  String adDuration = '1 day';

  AdArguments(this.adTitle,
    this.adCategory,
    this.adReviewType,
    this.adDescription,
    this.adCreatedTime,
    this.adOwnerId,
    this.adOwnerName,
    this.adOwnerEmail,
    this.adPrice,
    this.adDuration,);
}

class Ad extends StatefulWidget {
  const Ad({super.key});

  @override
  State<Ad> createState() => _AdState();
}

class _AdState extends State<Ad> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as AdArguments;
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