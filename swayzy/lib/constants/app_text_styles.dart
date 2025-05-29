import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_font_sizes.dart';
import 'app_fonts.dart';

class AppTextStyles {
  static const TextStyle _base = TextStyle(fontFamily: AppFonts.fontFamily);

  static final TextStyle title = _base.copyWith(
    color: AppColors.text,
    fontSize: AppFontSizes.title,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle body = _base.copyWith(
    color: AppColors.text,
    fontSize: AppFontSizes.body,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle form = _base.copyWith(
    color: AppColors.text,
    fontSize: AppFontSizes.body,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle setting = _base.copyWith(
    color: AppColors.text,
    fontSize: AppFontSizes.button,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle smallDescription = _base.copyWith(
    color: AppColors.secondaryText,
    fontSize: AppFontSizes.small,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle error = _base.copyWith(
    color: AppColors.error,
    fontSize: AppFontSizes.small,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle buttonPrimary = _base.copyWith(
    color: AppColors.text,
    fontSize: AppFontSizes.button,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle buttonSecondary = _base.copyWith(
    color: AppColors.secondaryText,
    fontSize: AppFontSizes.button,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle buttonAuth = _base.copyWith(
    color: AppColors.secondaryText,
    fontSize: AppFontSizes.body,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle orderCategory = _base.copyWith(
    color: AppColors.secondaryText,
    fontSize: AppFontSizes.orderCategory,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle orderCategoryWhite = _base.copyWith(
    color: AppColors.text,
    fontSize: AppFontSizes.orderCategory,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle orderDescription = _base.copyWith(
    color: AppColors.secondaryText,
    fontSize: AppFontSizes.orderDescription,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle orderTitle = _base.copyWith(
    color: AppColors.text,
    fontSize: AppFontSizes.body,
    fontWeight: FontWeight.bold,
  );
}
