import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/helpers.dart';
import 'package:jawline_fitness/utils/routes.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/utils/svg_assets.dart';
import 'package:jawline_fitness/widgets/buttons/tertiary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/exercise.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import '../widgets/counter.dart';
import '../widgets/app_bars/exercise_app_bar.dart';
import '../widgets/exercise_name.dart';

class ExerciseScreen extends StatefulWidget {
  // final int day;
  // final Exercise exercise;
  const ExerciseScreen({
    super.key,
  });
  @override
  ExerciseScreenState createState() => ExerciseScreenState();
}

class ExerciseScreenState extends State<ExerciseScreen> {
  late int currentExercise;
  late Exercise exercise;
  late int totalExerciseTime;
  late int currentExerciseTime;
  late int day;
  late String exerciseName;
  late String exerciseDescription;
  late List<String> exerciseSteps;
  bool isPaused = false;
  bool isLoading = true;

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    day = prefs.getInt("currentDay") ?? 0;
    currentExercise = prefs.getInt("currentExercise") ?? 0;
    exercise = Constants.days[day].exercises[currentExercise];
    totalExerciseTime = exercise.duration;
    currentExerciseTime = exercise.duration;
    exerciseName = exercise.title;
    exerciseDescription = exercise.description;
    exerciseSteps = exercise.steps;
    isLoading = false;
    startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }

  void startTimer() async {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      if (!isPaused && currentExerciseTime > 0) {
        setState(() {
          currentExerciseTime--;
        });
      }
      if (currentExerciseTime <= 0) {
        timer.cancel();
        await updateData();
      }
    });
  }

  void pauseTimer() {
    setState(() {
      isPaused = !isPaused;
    });
  }

  void skipExercise() async {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      timer.cancel();
      await updateData();
    });
  }

  Future<void> updateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (currentExercise < 5) {
      prefs.setInt('currentExercise', currentExercise + 1);
      Navigator.pushReplacementNamed(context, AppRoutes.restScreen);
    } else {
      Constants.days[day].completeDay();
      prefs.setInt('currentDay', day + 1);
      prefs.setInt('currentExercise', 0);
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.completeScreen,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
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
                  "Loading Exercise",
                  style: AppStyles.description,
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      double progress =
          (totalExerciseTime - currentExerciseTime) / totalExerciseTime;
      return Scaffold(
          backgroundColor: AppColors.lightBlack,
          appBar: ExerciseAppBar(day: day + 1),
          body: SizeConfig.isLandscape
              ? _buildLandscapeLayout(progress)
              : _buildPortraitLayout(progress));
    }
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
                  onHelpPressed: () => Helpers.aboutExercise(
                      context: context, exercise: exercise),
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
                    onHelpPressed: () => Helpers.aboutExercise(
                        context: context, exercise: exercise),
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
