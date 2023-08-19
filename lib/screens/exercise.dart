import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/routes.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/utils/svg_assets.dart';
import 'package:jawline_fitness/widgets/buttons/tertiary_button.dart';
import '../widgets/counter.dart';
import '../widgets/exercise_app_bar.dart';
import '../widgets/exercise_name.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  ExerciseScreenState createState() => ExerciseScreenState();
}

class ExerciseScreenState extends State<ExerciseScreen> {
  int totalExerciseTime = 300;
  int currentExerciseTime = 300;
  int day = 1;
  String exerciseName = "Lateral Raises";
  bool isPaused = false;

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!isPaused && currentExerciseTime > 0) {
        setState(() {
          currentExerciseTime--;
        });
      }
      if (currentExerciseTime <= 0) {
        timer.cancel();
        Navigator.pushReplacementNamed(context, Routes.restScreen);
      }
    });
  }

  void pauseTimer() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void skipExercise() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      timer.cancel();
      Navigator.pushReplacementNamed(context, Routes.restScreen);
    });
  }

  void aboutExercise() {}

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    double progress =
        (totalExerciseTime - currentExerciseTime) / totalExerciseTime;

    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: ExerciseAppBar(day: day),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: AppStyles.illustrationContainer,
                child: Stack(
                  alignment: Alignment.center,
                  children: [SvgAssets.line1],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(42),
              child: Column(
                children: [
                  ExerciseName(
                    exerciseName: exerciseName,
                    onHelpPressed: aboutExercise,
                  ),
                  const SizedBox(height: 35),
                  Counter(currentExerciseTime: currentExerciseTime),
                  const SizedBox(height: 35),
                  _buildPauseButton(progress),
                  const SizedBox(height: 35),
                  _buildActionButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPauseButton(double progress) {
    return AnimatedContainer(
      clipBehavior: Clip.antiAlias,
      height: 50,
      decoration:
          isPaused ? AppStyles.yellowOutline : AppStyles.darkGreyOutline,
      duration: const Duration(milliseconds: 300),
      child: ElevatedButton(
        onPressed: pauseTimer,
        style: AppStyles.zeroPadding,
        child: Stack(
          children: [
            LinearProgressIndicator(
              value: progress,
              minHeight: 50,
              backgroundColor: AppColors.lightBlack,
              color: AppColors.darkGrey,
            ),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(isPaused ? 'Resume' : 'Pause',
                      style: AppStyles.secondaryButtonText),
                  const SizedBox(width: 5),
                  Icon(isPaused ? Icons.play_arrow : Icons.pause,
                      color: AppColors.grey, size: 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TertiaryButton(
          text: 'Previous',
          icon: Icons.skip_previous_outlined,
          onPressed: () {},
          isDisabled: true,
          isSkip: false,
        ),
        TertiaryButton(
            text: 'Skip',
            icon: Icons.skip_next_outlined,
            onPressed: skipExercise),
      ],
    );
  }
}
