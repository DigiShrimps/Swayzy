import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      titleTextStyle: AppTextStyles.title,
      backgroundColor: AppColors.secondaryBackground,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: true
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}