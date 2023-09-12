import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/routes.dart';
import 'package:jawline_fitness/widgets/counter.dart';
import '../utils/size_config.dart';
import '../utils/styles.dart';
import '../utils/svg_assets.dart';
import '../widgets/bottom_sheets/about_exercise_bottom_sheet.dart';
import '../widgets/buttons/secondary_button.dart';
import '../widgets/buttons/tertiary_button.dart';
import '../widgets/app_bars/exercise_app_bar.dart';
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
  String exerciseDescription =
      "Lateral raises, also known as lateral deltoid raises or lateral shoulder raises, are a common strength-training exercise that primarily targets the lateral deltoid muscles, which are the muscles on the sides of your shoulders. Here's how to perform lateral raises:Stand upright with a dumbbell in each hand, hanging at arm's length by your sides. Ensure your feet are about hip-width apart for stability.Maintain a slight bend in your elbows throughout the exercise, but keep them mostly straight.Engage your core for stability and maintain proper posture with your chest up and shoulders back.To begin the exercise, simultaneously raise both arms out to the sides until they are approximately parallel to the ground. Keep your palms facing downward throughout the movement.Hold the raised position for a brief moment, focusing on the contraction in your lateral deltoid muscles.Slowly lower the dumbbells back to the starting position, maintaining control and preventing any swinging or jerking motions.Repeat the exercise for the desired number of repetitions.Lateral raises are an effective way to isolate and strengthen the lateral deltoids, which can help improve shoulder definition and overall shoulder strength. It's essential to use proper form and select an appropriate weight to avoid straining the shoulder joints. If you're new to the exercise, start with lighter weights and gradually increase as you become more comfortable with the movement.";
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
          AppRoutes.completeScreen,
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
        AppRoutes.completeScreen,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void aboutExercise() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AboutExerciseBottomSheet(
          exerciseTitle: nextExerciseName,
          exerciseDescription: exerciseDescription,
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: ExerciseAppBar(day: day),
      body: SizeConfig.isLandscape
          ? _buildLandscapeLayout()
          : _buildPortraitLayout(),
    );
  }

  Column _buildPortraitLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: AppStyles.bottomOutlineYellow,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgAssets.createLineSvg(
                  SvgAssets.line4,
                  SizeConfig.screenWidth,
                  SizeConfig.screenHeight,
                ),
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
                      onPressed: incrementTimer,
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
    );
  }

  Row _buildLandscapeLayout() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: AppStyles.rightOutlineYellow,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgAssets.createLineSvg(
                  SvgAssets.line4,
                  SizeConfig.screenWidth,
                  SizeConfig.screenHeight,
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Rest Break",
                        style: AppStyles.secondaryHeading,
                      ),
                      const SizedBox(height: 25),
                      Counter(currentExerciseTime: restTime),
                      const SizedBox(height: 25),
                      SecondaryButton(
                        onPressed: incrementTimer,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(height: 15),
              TertiaryButton(
                  text: 'Skip Rest',
                  icon: Icons.skip_next_outlined,
                  onPressed: skipRest),
            ],
          ),
        ),
      ],
    );
  }
}
