import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/styles.dart';

class SecondaryButton extends StatelessWidget {
  final void Function() onPressed;

  const SecondaryButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed();
      },
      style: AppStyles.secondaryButton,
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.add_rounded,
            color: AppColors.grey,
            size: 24,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            '20 sec',
            style: AppStyles.alternateSecondaryButtonText,
          ),
        ],
      ),
    );
  }
}
