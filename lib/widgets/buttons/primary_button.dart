import 'package:flutter/material.dart';

import '../../utils/styles.dart';

class PrimaryButton extends StatelessWidget {
  final void Function() onPressed;
  final bool fullWidth;
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: AppStyles.primaryButton,
      child: Padding(
        padding: fullWidth ? EdgeInsets.zero : EdgeInsets.fromLTRB(10, 0, 5, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (fullWidth)
              Text(
                String.fromCharCode(Icons.chevron_left_rounded.codePoint),
                style: AppStyles.boldIconYellow,
              ),
            const Text(
              'Next',
              style: AppStyles.primaryButtonText,
            ),
            Text(
              String.fromCharCode(Icons.chevron_right_rounded.codePoint),
              style: AppStyles.boldIconBlack,
            ),
          ],
        ),
      ),
    );
  }
}
