import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/routes.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/utils/svg_assets.dart';
import 'package:jawline_fitness/widgets/buttons/tertiary_button.dart';
import '../utils/size_config.dart';
import '../widgets/bottom_sheets/about_exercise_bottom_sheet.dart';
import '../widgets/counter.dart';
import '../widgets/app_bars/exercise_app_bar.dart';
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
  String exerciseDescription =
      "Lateral raises, also known as lateral deltoid raises or lateral shoulder raises, are a common strength-training exercise that primarily targets the lateral deltoid muscles, which are the muscles on the sides of your shoulders. Here's how to perform lateral raises:Stand upright with a dumbbell in each hand, hanging at arm's length by your sides. Ensure your feet are about hip-width apart for stability.Maintain a slight bend in your elbows throughout the exercise, but keep them mostly straight.Engage your core for stability and maintain proper posture with your chest up and shoulders back.To begin the exercise, simultaneously raise both arms out to the sides until they are approximately parallel to the ground. Keep your palms facing downward throughout the movement.Hold the raised position for a brief moment, focusing on the contraction in your lateral deltoid muscles.Slowly lower the dumbbells back to the starting position, maintaining control and preventing any swinging or jerking motions.Repeat the exercise for the desired number of repetitions.Lateral raises are an effective way to isolate and strengthen the lateral deltoids, which can help improve shoulder definition and overall shoulder strength. It's essential to use proper form and select an appropriate weight to avoid straining the shoulder joints. If you're new to the exercise, start with lighter weights and gradually increase as you become more comfortable with the movement.";
  bool isPaused = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!isPaused && currentExerciseTime > 0) {
        setState(() {
          currentExerciseTime--;
        });
      }
      if (currentExerciseTime <= 0) {
        timer.cancel();
        Navigator.pushReplacementNamed(context, AppRoutes.restScreen);
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
      Navigator.pushReplacementNamed(context, AppRoutes.restScreen);
    });
  }

  void aboutExercise() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AboutExerciseBottomSheet(
          exerciseTitle: exerciseName,
          exerciseDescription: exerciseDescription,
        );
      },
    );
  }

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
        body: SizeConfig.isLandscape
            ? _buildLandscapeLayout(progress)
            : _buildPortraitLayout(progress));
  }

  Center _buildPortraitLayout(double progress) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: AppStyles.bottomOutlineYellow,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgAssets.createLineSvg(SvgAssets.line1,
                      SizeConfig.screenWidth, SizeConfig.screenHeight * 0.5)
                ],
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
    );
  }

  Center _buildLandscapeLayout(double progress) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              width: SizeConfig.screenWidth * 0.5,
              height: SizeConfig.screenHeight,
              decoration: AppStyles.rightOutlineYellow,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgAssets.createLineSvg(SvgAssets.line1,
                      SizeConfig.screenWidth * 0.5, SizeConfig.screenHeight)
                ],
              ),
            ),
          ),
          Container(
            width: SizeConfig.screenWidth * 0.5,
            padding: const EdgeInsets.fromLTRB(42, 0, 42, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ExerciseName(
                    exerciseName: exerciseName,
                    onHelpPressed: aboutExercise,
                  ),
                  const SizedBox(height: 25),
                  Counter(currentExerciseTime: currentExerciseTime),
                  const SizedBox(height: 25),
                  _buildPauseButton(progress),
                  const SizedBox(height: 5),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ],
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
