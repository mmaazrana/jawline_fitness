import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/routes.dart';
import 'package:jawline_fitness/widgets/counter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/exercise.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
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
  late int day;
  late int nextExercise;
  late Exercise exercise;
  late int restTime; // Current exercise time in seconds
  late String nextExerciseName;
  late int nextExerciseTime;
  bool isLoading = true;
  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (restTime > 0) {
        setState(() {
          restTime--;
        });
      }
      if (restTime <= 0) {
        timer.cancel();
        Navigator.pushReplacementNamed(context, AppRoutes.exerciseScreen);
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
      Navigator.pushReplacementNamed(context, AppRoutes.exerciseScreen);
    });
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    day = prefs.getInt("currentDay") ?? 0;
    nextExercise = prefs.getInt("currentExercise") ?? 0;
    restTime = prefs.getInt("restDuration") ?? 20;
    exercise = Constants.days[day].exercises[nextExercise];
    nextExerciseTime = exercise.duration;
    nextExerciseName = exercise.title;
    isLoading = false;
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.lightBlack,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.yellow,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Loading Next Exercise",
                  style: AppStyles.description,
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: AppColors.lightBlack,
        appBar: ExerciseAppBar(day: day + 1),
        body: SizeConfig.isLandscape
            ? _buildLandscapeLayout()
            : _buildPortraitLayout(),
      );
    }
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
                onHelpPressed: () =>
                    Helpers.aboutExercise(context: context, exercise: exercise),
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
                onHelpPressed: () =>
                    Helpers.aboutExercise(context: context, exercise: exercise),
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
