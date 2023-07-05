import 'package:flutter/material.dart';
import 'package:jawline_fitness/widgets/step.dart';

class CustomStepper extends StatelessWidget {
  final int step;

  const CustomStepper({
    required this.step,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomStep(
          currentStep: step,
          position: 0,
        ),
        CustomStep(
          currentStep: step,
          position: 1,
        ),
        CustomStep(
          currentStep: step,
          position: 2,
        ),
        CustomStep(
          currentStep: step,
          position: 3,
        ),
        CustomStep(
          currentStep: step,
          position: 4,
        ),
      ],
    );
  }
}
