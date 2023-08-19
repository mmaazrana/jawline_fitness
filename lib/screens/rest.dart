import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/routes.dart';
import 'package:jawline_fitness/widgets/counter.dart';
import '../utils/styles.dart';
import '../utils/svg_assets.dart';
import '../widgets/buttons/secondary_button.dart';
import '../widgets/buttons/tertiary_button.dart';
import '../widgets/exercise_app_bar.dart';
import '../widgets/exercise_name.dart';

class RestScreen extends StatefulWidget {
  const RestScreen({super.key});

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  int day = 1;
  int restTime = 300; // Current exercise time in seconds
  String nextExerciseName = "Side Raises";
  int nextExerciseTime = 300;
  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (restTime > 0) {
        setState(() {
          restTime--;
        });
      }
      if (restTime <= 0) {
        timer.cancel();
        // Navigate to RestScreen when exercise is completed
        Navigator.pushReplacementNamed(
          context,
          Routes.completeScreen,
        );
      }
    });
  }

  void incrementTimer() {
    setState(() {
      restTime += 20;
    });
  }

  void skipRest() {
    // Cancel the timer and navigate to RestScreen
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      timer.cancel();
      Navigator.pushReplacementNamed(
        context,
        Routes.completeScreen,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void aboutExercise() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: ExerciseAppBar(day: day),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: AppStyles.illustrationContainer,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgAssets.line2,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Rest Break",
                        style: AppStyles.secondaryHeading,
                      ),
                      const SizedBox(height: 45),
                      Counter(currentExerciseTime: restTime),
                      const SizedBox(height: 45),
                      SecondaryButton(
                        onPressed: skipRest,
                      ),
                      const SizedBox(height: 15),
                      TertiaryButton(
                          text: 'Skip',
                          icon: Icons.skip_next_outlined,
                          onPressed: skipRest),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 35, 25, 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upcoming',
                  style: AppStyles.alternateDescription,
                ),
                const SizedBox(height: 10),
                ExerciseName(
                  exerciseName: nextExerciseName,
                  onHelpPressed: aboutExercise,
                ),
                const SizedBox(height: 5),
                Text(
                  "${(nextExerciseTime ~/ 60).toString().padLeft(2, '0')}:${(nextExerciseTime % 60).toString().padLeft(2, '0')}",
                  style: AppStyles.alternateCounterText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
