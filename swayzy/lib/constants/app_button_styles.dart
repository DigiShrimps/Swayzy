import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppButtonStyles{

  static final ButtonStyle _base = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50.0),
    ),
  );

  static final ButtonStyle primary = _base.copyWith(
    backgroundColor: WidgetStateProperty.all(AppColors.highlight),
    foregroundColor: WidgetStateProperty.all(AppColors.text),
    textStyle: WidgetStateProperty.all(AppTextStyles.buttonPrimary),
  );

  static final ButtonStyle settings = _base.copyWith(
    backgroundColor: WidgetStateProperty.all(AppColors.primaryBackground),
    foregroundColor: WidgetStateProperty.all(AppColors.highlight),
    textStyle: WidgetStateProperty.all(AppTextStyles.buttonSecondary),
  );

  static final ButtonStyle secondary = _base.copyWith(
    backgroundColor: WidgetStateProperty.all(AppColors.primaryBackground),
    foregroundColor: WidgetStateProperty.all(AppColors.highlight),
    textStyle: WidgetStateProperty.all(AppTextStyles.buttonSecondary),
    side: WidgetStateProperty.all(
      const BorderSide(
        color: AppColors.highlight,
        width: 2.0,
        style: BorderStyle.solid,
      ),
    ),
  );

  static final ButtonStyle delete = _base.copyWith(
    foregroundColor: WidgetStateProperty.all(AppColors.text),
    backgroundColor: WidgetStateProperty.all(AppColors.error),
    textStyle: WidgetStateProperty.all(AppTextStyles.buttonAuth),
    side: WidgetStateProperty.all(
      const BorderSide(
        color: AppColors.error,
        width: 2.0,
        style: BorderStyle.solid,
      ),
    ),
  );

  static final ButtonStyle chat = _base.copyWith(
    backgroundColor: WidgetStateProperty.all(AppColors.secondaryBackground),
    shape: WidgetStateProperty.all(RoundedRectangleBorder()),
  );
}
