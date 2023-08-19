import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/routes.dart';
import 'package:jawline_fitness/utils/size_config.dart';
import 'package:jawline_fitness/utils/svg_assets.dart';

import '../widgets/counter.dart';
import '../widgets/exercise_app_bar.dart';
import 'rest.dart';

class ExerciseScreen extends StatefulWidget {
  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int totalExerciseTime = 300; // Total exercise time in seconds
  int currentExerciseTime = 300; // Current exercise time in seconds
  int day = 1;
  String exerciseName = "Lateral Raises";
  bool isPaused = false;

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (!isPaused && currentExerciseTime > 0) {
        setState(() {
          currentExerciseTime--;
        });
      }
      if (currentExerciseTime <= 0) {
        timer.cancel();
        // Navigate to RestScreen when exercise is completed
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
    // Cancel the timer and navigate to RestScreen
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      timer.cancel();
      Navigator.pushReplacementNamed(
        context,
        Routes.restScreen,
      );
    });
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
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.yellow,
                      width: 3,
                    ),
                    top: BorderSide(
                      color: AppColors.darkGrey,
                      width: 3,
                    ),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [SvgAssets.line1],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(42),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$exerciseName',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.grey, width: 2),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.question_mark_rounded,
                              color: AppColors.grey,
                              size: 14,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 35),
                  Counter(currentExerciseTime: currentExerciseTime),
                  SizedBox(height: 35),
                  AnimatedContainer(
                    clipBehavior: Clip.antiAlias,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.lightBlack,
                      border: Border.all(
                        color: isPaused ? AppColors.yellow : AppColors.darkGrey,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    duration: const Duration(milliseconds: 300),
                    child: ElevatedButton(
                      onPressed: () {
                        pauseTimer();
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.zero),
                      ),
                      child: Stack(
                        children: [
                          LinearProgressIndicator(
                            value: progress,
                            minHeight: 50,
                            backgroundColor: AppColors.lightBlack,
                            color: AppColors
                                .darkGrey, // Change to your desired color
                          ),
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  isPaused ? 'Resume' : 'Pause',
                                  style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  isPaused ? Icons.play_arrow : Icons.pause,
                                  color: AppColors.grey,
                                  size: 28,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.skip_previous_outlined,
                              color: AppColors.darkGrey,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Previous',
                              style: TextStyle(
                                  color: AppColors.darkGrey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          skipExercise();
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.lightBlack),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Skip',
                              style: TextStyle(
                                  color: AppColors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.skip_next_outlined,
                              color: AppColors.grey,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
