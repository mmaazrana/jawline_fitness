import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/routes.dart';
import 'package:jawline_fitness/widgets/counter.dart';

import '../utils/size_config.dart';

class RestScreen extends StatefulWidget {
  const RestScreen({super.key});

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  int day = 1;
  // int totalExerciseTime = 300; // Total exercise time in seconds
  int restTime = 300; // Current exercise time in seconds
  String nextExerciseName = "Side Raises";
  int nextExerciseTime = 300;

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
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
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 80,
        leading: Icon(
          Icons.chevron_left_rounded,
          size: 40,
          color: AppColors.grey,
        ),
        elevation: 0,
        actions: [
          Icon(
            Icons.more_vert_rounded,
            size: 28,
            color: AppColors.grey,
          ),
          SizedBox(
            width: 20,
          ),
        ],
        title: Text(
          'Day $day',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: AppColors.lightBlack,
        foregroundColor: AppColors.grey,
      ),
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
                  children: [
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Container(
                        width: SizeConfig.screenWidth,
                        child: Transform.scale(
                          scale: 1.35,
                          child: SvgPicture.asset(
                            "assets/line2.svg",
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Rest Break",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 32,
                              color: AppColors.grey,
                            )),
                        SizedBox(
                          height: 45,
                        ),
                        Counter(currentExerciseTime: restTime),
                        SizedBox(
                          height: 45,
                        ),
                        TextButton(
                          onPressed: () {
                            incrementTimer();
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(37, 12, 37, 12)),
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.darkGrey),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_rounded,
                                color: AppColors.grey,
                                size: 24,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '20 sec',
                                style: TextStyle(
                                    color: AppColors.grey,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextButton(
                          onPressed: () {
                            skipRest();
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
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 35, 25, 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upcoming',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        '$nextExerciseName',
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
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        (nextExerciseTime ~/ 60).toString().padLeft(2, '0'),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.yellow,
                        ),
                      ),
                      Text(
                        ':',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.yellow,
                        ),
                      ),
                      Text(
                        (nextExerciseTime % 60).toString().padLeft(2, '0'),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.yellow,
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
