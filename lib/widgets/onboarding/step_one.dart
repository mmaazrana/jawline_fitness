import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class StepOne extends StatelessWidget {
  const StepOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(25.0),
      child: Text(
        'Step 1 Illustration',
        style: TextStyle(
          color: AppColors.white,
        ),
      ),
    );
  }
}
