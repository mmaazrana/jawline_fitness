import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/size_config.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/widgets/lists/exercise_list.dart';

import '../utils/colors.dart';
import '../widgets/app_bars/exercise_app_bar.dart';

class DayPreview extends StatelessWidget {
  final int day;

  const DayPreview({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: ExerciseAppBar(day: day),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 278,
              alignment: Alignment.center,
              child: Text(
                "Day $day Preview",
                style: AppStyles.heading,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.darkGrey,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(24),
              height: SizeConfig.screenHeight - 400,
              child: ExercisesList(day: day),
            ),
          ],
        ),
      ),
    );
  }
}
