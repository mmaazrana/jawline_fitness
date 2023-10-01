import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/styles.dart';

class SecondaryButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final bool hasIcon;
  const SecondaryButton({
    super.key,
    required this.onPressed,
    this.text = "20 sec",
    this.hasIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      style: AppStyles.secondaryButton,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasIcon)
            const Icon(
              Icons.add_rounded,
              color: AppColors.grey,
              size: 24,
            ),
          const SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: AppStyles.alternateSecondaryButtonText,
          ),
        ],
      ),
    );
  }
}
