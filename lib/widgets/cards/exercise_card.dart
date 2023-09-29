import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/size_config.dart';

import '../../models/exercise.dart';
import '../../utils/helpers.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;

  const ExerciseCard({
    super.key,
    required this.exercise,
    // required this.title,
    // required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Helpers.aboutExercise(context: context, exercise: exercise);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(16.0),
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.darkGrey,
          border: Border.all(
            color: AppColors.darkGrey,
            width: 2.0,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: AppColors.yellow,
                borderRadius: BorderRadius.circular(6),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset('assets/logo.png'),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth - 34 - 34 - 88,
                  child: Text(
                    exercise.title,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.grey,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(
                  "Duration: ${exercise.duration} s",
                  style: const TextStyle(
                    color: AppColors.grey,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
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
