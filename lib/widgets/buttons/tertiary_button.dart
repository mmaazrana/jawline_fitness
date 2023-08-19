import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/styles.dart';

class TertiaryButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function() onPressed;
  final bool isDisabled;
  final bool isSkip;

  const TertiaryButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isDisabled = false,
    this.isSkip = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: AppStyles.skipButton,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: isSkip
            ? [
                Text(
                  text,
                  style: isDisabled
                      ? AppStyles.tertiaryButtonTextDisabled
                      : AppStyles.tertiaryButtonText,
                ),
                const SizedBox(width: 5),
                Icon(
                  icon,
                  color: isDisabled ? AppColors.darkGrey : AppColors.grey,
                  size: 20,
                ),
              ]
            : [
                Icon(
                  icon,
                  color: isDisabled ? AppColors.darkGrey : AppColors.grey,
                  size: 20,
                ),
                const SizedBox(width: 5),
                Text(
                  text,
                  style: isDisabled
                      ? AppStyles.tertiaryButtonTextDisabled
                      : AppStyles.tertiaryButtonText,
                ),
              ],
      ),
    );
  }
}
