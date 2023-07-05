import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';

class CustomStep extends StatelessWidget {
  final int position;
  final int currentStep;

  const CustomStep({
    required this.position,
    required this.currentStep,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (position > 0)
          Container(
            width: 20,
            height: 4,
            color:
                position <= currentStep ? AppColors.yellow : AppColors.darkGrey,
          ),
        CircleAvatar(
          backgroundColor:
              position <= currentStep ? AppColors.yellow : AppColors.darkGrey,
          radius: 12,
        ),
      ],
    );
  }
}
