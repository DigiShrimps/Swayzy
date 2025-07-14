import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class AnimatedButtons<T> extends StatelessWidget {
  final String firstLabel;
  final String secondLabel;
  final T currentMode;
  final T leftMode;
  final T rightMode;
  final ValueChanged<T> onChanged;

  const AnimatedButtons({
    super.key,
    required this.firstLabel,
    required this.secondLabel,
    required this.currentMode,
    required this.leftMode,
    required this.rightMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<bool>.size(
      current: currentMode == leftMode,
      values: const [true, false],
      iconOpacity: 0.2,
      indicatorSize: const Size.fromWidth(double.infinity),
      customIconBuilder: (context, local, global) => Text(
        local.value ? firstLabel : secondLabel,
        style: AppTextStyles.buttonPrimary,
      ),
      iconAnimationType: AnimationType.onHover,
      style: ToggleStyle(
        indicatorColor: AppColors.highlight,
        borderColor: AppColors.highlight,
        borderRadius: BorderRadius.circular(0),
      ),
      selectedIconScale: 1.0,
      onChanged: (value) {
        onChanged(value ? leftMode : rightMode);
      },
      animationDuration: Duration(milliseconds: 250),
    );
  }
}
