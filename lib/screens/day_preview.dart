import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jawline_fitness/utils/constants.dart';
import 'package:jawline_fitness/utils/size_config.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/widgets/buttons/primary_button.dart';
import 'package:jawline_fitness/widgets/lists/exercise_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/day.dart';
import '../utils/colors.dart';
import '../utils/routes.dart';
import '../widgets/app_bars/exercise_app_bar.dart';

class DayPreview extends StatefulWidget {
  final int day;

  const DayPreview({
    super.key,
    required this.day,
  });

  @override
  State<DayPreview> createState() => _DayPreviewState();
}

class _DayPreviewState extends State<DayPreview> {
  late final Box<Day> daysBox;
  late final bool isRest;
  void loadData() async {
    isRest = Constants.days[widget.day - 1].exercises.isEmpty;
    daysBox = await Hive.openBox<Day>('days_box');
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  void startDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('trainingComplete', false);
    prefs.setInt('currentDay', widget.day - 1);
    prefs.setInt('currentExercise', 0);
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.exerciseScreen,
    );
  }

  void completeDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final dayToUpdate = daysBox.get(widget.day - 1);
    print(dayToUpdate!.isComplete);
    dayToUpdate.isComplete = true;
    dayToUpdate.completedOn = DateTime.now();
    await dayToUpdate.save(); // Save the updated Day back to the box
    int nextDay = widget.day;
    while (daysBox.get(nextDay)!.isComplete && nextDay < 35) {
      nextDay++;
      if (nextDay == 35) {
        prefs.setBool('trainingComplete', true);
      }
    }
    prefs.setInt('currentDay', nextDay);
    prefs.setInt('currentExercise', 0);
    Navigator.pushReplacementNamed(
      context,
      AppRoutes.home,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: ExerciseAppBar(day: widget.day),
      body: SingleChildScrollView(
        child: isRest ? _buildRestLayout() : _buildDayLayout(),
      ),
    );
  }

  Widget _buildRestLayout() {
    return Column(
      children: [
        Container(
          height: 168,
          alignment: Alignment.center,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Rest Day",
                style: AppStyles.heading,
              ),
              SizedBox(height: 5),
              Text(
                "Take a well deserved break.",
                style: AppStyles.description,
              ),
            ],
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
          child: SvgPicture.asset(
            "assets/rest.svg",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: PrimaryButton(
            onPressed: () => completeDay(),
            text: "Complete Day",
          ),
        ),
      ],
    );
  }

  Widget _buildDayLayout() {
    return Column(
      children: [
        Container(
          height: 168,
          alignment: Alignment.center,
          child: Text(
            "Day ${widget.day} Preview",
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
          child: ExercisesList(day: widget.day),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: PrimaryButton(
            onPressed: () => startDay(),
            text: "Start Day",
          ),
        ),
      ],
    );
  }
}
