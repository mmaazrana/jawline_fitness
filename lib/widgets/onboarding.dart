import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/size_config.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/widgets/stepper.dart';

class OnBoarding extends StatefulWidget {
  final String heading;
  final String description;
  final int step;

  const OnBoarding({
    Key? key,
    required this.heading,
    required this.description,
    required this.step,
  }) : super(key: key);

  @override
  OnBoardingState createState() => OnBoardingState();
}

class OnBoardingState extends State<OnBoarding> {
  int currentStep = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }

  void _nextStep() {
    setState(() {
      if (currentStep < 5) {
        currentStep++;
      }
    });
  }

  void _previousStep() {
    setState(() {
      if (currentStep > 0) {
        currentStep--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Text(
              widget.heading,
              style: AppStyles.heading,
            ),
            const SizedBox(height: 16),
            Text(
              widget.description,
              style: AppStyles.description,
            ),
            const SizedBox(height: 32),
            CustomStepper(step: currentStep),
            Stepper(
              currentStep: currentStep,
              onStepContinue: () {
                _nextStep();
              },
              onStepCancel: () {
                _previousStep();
              },
              steps: const [
                Step(
                  title: Text(
                    'Step 1',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                  content: Text(
                    'Step 1 description',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                ),
                Step(
                  title: Text(
                    'Step 2',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                  content: Text(
                    'Step 2 description',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                ),
                Step(
                  title: Text(
                    'Step 3',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                  content: Text(
                    'Step 3 description',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                ),
                Step(
                  title: Text(
                    'Step 4',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                  content: Text(
                    'Step 4 description',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                ),
                Step(
                  title: Text(
                    'Step 5',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                  content: Text(
                    'Step 5 description',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _nextStep();
                  },
                  style: AppStyles.primaryButton,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        String.fromCharCode(
                            Icons.chevron_left_rounded.codePoint),
                        style: AppStyles.boldIconYellow,
                      ),
                      Text(
                        'Next',
                        style: AppStyles.primaryButtonText,
                      ),
                      Text(
                        String.fromCharCode(
                            Icons.chevron_right_rounded.codePoint),
                        style: AppStyles.boldIconBlack,
                      ),
                    ],
                  ),
                ),
                if (currentStep > 0)
                  TextButton(
                    style: AppStyles.secondaryButton,
                    onPressed: () {
                      _previousStep();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.chevron_left,
                          size: 22,
                          color: AppColors.grey,
                        ),
                        Text(
                          'Back',
                          style: AppStyles.secondaryButtonText,
                        ),
                        const Icon(
                          Icons.chevron_left,
                          size: 22,
                          color: AppColors.lightBlack,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
