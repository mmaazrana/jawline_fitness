import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/constants.dart';
import 'package:jawline_fitness/utils/size_config.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/widgets/buttons/primary_button.dart';
import 'package:jawline_fitness/widgets/lists/exercise_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors.dart';
import '../widgets/app_bars/exercise_app_bar.dart';
import 'exercise.dart';

class DayPreview extends StatelessWidget {
  final int day;

  const DayPreview({
    super.key,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    void startDay() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('currentDay', day - 1);
      prefs.setInt('currentExercise', 0);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (builder) {
        return ExerciseScreen(
            // day: day,
            // exercise: Constants.days[day - 1].exercises[0],
            );
      }));
    }

    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: ExerciseAppBar(day: day),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 168,
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
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: PrimaryButton(
                onPressed: startDay,
                text: "Start Day",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
