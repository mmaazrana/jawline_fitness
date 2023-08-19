import 'package:flutter/material.dart';

import '../utils/colors.dart';

class HelpIcon extends StatelessWidget {
  const HelpIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey, width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Icon(
        Icons.question_mark_rounded,
        color: AppColors.grey,
        size: 14,
      ),
    );
  }
}
