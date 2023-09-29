import 'package:flutter/material.dart';
import 'package:jawline_fitness/screens/exercise.dart';
import 'package:jawline_fitness/widgets/lists/levels_list.dart';

import '../../models/exercise.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/routes.dart';
import '../../utils/size_config.dart';
import '../../utils/styles.dart';
import '../lists/days_list.dart';

class TrainingPage extends StatelessWidget {
  final int day = 1;
  final Exercise exercise = Constants.exercises[0];

  TrainingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizeConfig.isLandscape
            ? _buildLandscapeLayout(context)
            : _buildPortraitLayout(context);
      },
    );
  }

  void continueTraining(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
      return ExerciseScreen(
        day: day,
        exercise: exercise,
      );
    }));
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 12, 10, 0),
            child: Column(
              children: [
                LevelsList(viewPortFraction: 1),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 12, 34, 0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    continueTraining(context);
                  },
                  style: AppStyles.primaryButton,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Continue",
                        style: AppStyles.primaryButtonText,
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 24,
                        color: AppColors.lightBlack,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: SizeConfig.screenHeight - 165,
                  child: const DaysList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 150,
          child: LevelsList(viewPortFraction: 0.9),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(34, 25, 34, 0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  continueTraining(context);
                },
                style: AppStyles.primaryButton,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Continue",
                      style: AppStyles.primaryButtonText,
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 24,
                      color: AppColors.lightBlack,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: SizeConfig.screenHeight - (25 + 45 + 150 + 220),
                child: const DaysList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
