import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/helpers.dart';
import 'package:jawline_fitness/utils/routes.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/utils/svg_assets.dart';
import 'package:jawline_fitness/widgets/buttons/tertiary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/day.dart';
import '../models/exercise.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import '../widgets/counter.dart';
import '../widgets/app_bars/exercise_app_bar.dart';
import '../widgets/exercise_name.dart';
import '../widgets/loader.dart';

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
  bool isVoiceEnabled = true;
  late final Box<Day> daysBox;
  FlutterTts flutterTts = FlutterTts();

  List<String> steps = [
    "Step 1: Prepare the ingredients.",
    "Step 2: Preheat the oven to 350 degrees Fahrenheit.",
    "Step 3: Mix the dry ingredients in a bowl.",
    // Add more steps as needed
  ];

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isVoiceEnabled = prefs.getBool('isVoiceEnabled') ?? true;
    daysBox = await Hive.openBox<Day>('days_box');
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
    if (isVoiceEnabled) readStepsSequentially();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }

  void startTimer() async {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) async {
      if (!isPaused && currentExerciseTime > 0) {
        if (mounted) {
          setState(() {
            currentExerciseTime--;
          });
        }
      }
      if (currentExerciseTime <= 0) {
        timer.cancel();
        await updateData();
      }
    });
  }

  void pauseTimer() {
    if (mounted) {
      setState(() {
        isPaused = !isPaused;
      });
    }
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
      final dayToUpdate = daysBox.get(day);
      dayToUpdate!.isComplete = true;
      dayToUpdate.completedOn = DateTime.now();
      await dayToUpdate.save(); // Save the updated Day back to the box
      int nextDay = day + 1;
      while (daysBox.get(nextDay)!.isComplete && nextDay < 35) {
        nextDay++;
        if (nextDay == 35) {
          await prefs.setBool('trainingComplete', true);
        }
      }
      prefs.setInt('currentDay', nextDay);
      prefs.setInt('currentExercise', 0);
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.completeScreen,
      );
    }
  }

  Future<void> initTts() async {
    await flutterTts
        .setLanguage("en-US"); // Set the desired language (e.g., English)
    await flutterTts.setPitch(1.0); // Set the pitch (1.0 is the default)
    await flutterTts.setSpeechRate(
        0.4); // Set the speech rate (0.6 is slower, 1.0 is normal)
  }

  void _cancelTts() async {
    await flutterTts.stop();
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setVolume(0); // Set volume to 0 to mute
    await flutterTts.setSpeechRate(0); // Set speech rate to 0 to stop
  }

  int currentStepIndex = 0;

  Future<void> _speak(String _text) async {
    if (_text.isNotEmpty) {
      await flutterTts.awaitSpeakCompletion(true);
      await flutterTts.speak(_text);
    }
  }

  Future<void> readStepsSequentially() async {
    if (currentStepIndex < exerciseSteps.length) {
      String step = exerciseSteps[currentStepIndex];
      await _speak(step).then((value) async => {
            currentStepIndex++,
            await Future.delayed(const Duration(
                seconds: 2)), // Wait for a few seconds before the next step
            await readStepsSequentially(), // Recursively call the function for the next step
          });
    } else {
      await Future.delayed(const Duration(seconds: 2));
      await flutterTts.awaitSpeakCompletion(true);
      await flutterTts.speak("Exercise Complete!");
    }
  }

  @override
  void initState() {
    super.initState();
    initTts();
    loadData();
  }

  @override
  void dispose() {
    _cancelTts();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Loader(text: "Loading Exercise");
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
