import 'package:flutter/material.dart';

import '../../utils/styles.dart';

class PrimaryButton extends StatelessWidget {
  final void Function() onPressed;
  final bool fullWidth;
  final bool hasIcon;
  String text;
  PrimaryButton({
    super.key,
    required this.onPressed,
    this.fullWidth = true,
    this.text = "Next",
    this.hasIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: AppStyles.primaryButton,
      child: Padding(
        padding: fullWidth
            ? EdgeInsets.zero
            : const EdgeInsets.fromLTRB(10, 0, 5, 0),
        child: Row(
          mainAxisAlignment: hasIcon
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            if (hasIcon)
              if (fullWidth)
                Text(
                  String.fromCharCode(Icons.chevron_left_rounded.codePoint),
                  style: AppStyles.boldIconYellow,
                ),
            Text(
              text,
              style: AppStyles.primaryButtonText,
            ),
            if (hasIcon)
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
