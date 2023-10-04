import 'package:flutter/material.dart';
import 'package:jawline_fitness/screens/exercise.dart';
import 'package:jawline_fitness/widgets/buttons/primary_button.dart';
import 'package:jawline_fitness/widgets/lists/levels_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/exercise.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/routes.dart';
import '../../utils/size_config.dart';
import '../../utils/styles.dart';
import '../lists/days_list.dart';
import '../loader.dart';

class TrainingPage extends StatefulWidget {
  TrainingPage({
    super.key,
  });

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  final int day = 1;
  final Exercise exercise = Constants.exercises[0];
  int currentLevel = 0;
  late bool trainingComplete = false;
  bool isLoading = true;

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool trainingCompleteData =
        prefs.getBool('trainingComplete') ?? false;
    setState(() {
      trainingComplete = trainingCompleteData;
      isLoading = false;
      print(prefs.getInt('currentDay'));
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void setCurrentLevel(int selectedLevel) =>
      setState(() => currentLevel = selectedLevel);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loader(text: "Loading Levels")
        : LayoutBuilder(
            builder: (context, constraints) {
              return SizeConfig.isLandscape
                  ? _buildLandscapeLayout(context)
                  : _buildPortraitLayout(context);
            },
          );
  }

  void continueTraining(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.exerciseScreen);
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 12, 10, 0),
            child: Column(
              children: [
                LevelsList(
                    viewPortFraction: 1, setCurrentLevel: setCurrentLevel),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: trainingComplete
                ? const EdgeInsets.fromLTRB(10, 3, 34, 0)
                : const EdgeInsets.fromLTRB(10, 12, 34, 0),
            child: Column(
              children: [
                if (!trainingComplete)
                  PrimaryButton(
                    onPressed: () => continueTraining(context),
                    text: "Continue",
                  ),
                // ElevatedButton(
                //   onPressed: () {
                //     continueTraining(context);
                //   },
                //   style: AppStyles.primaryButton,
                //   child: const Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       Text(
                //         "Continue",
                //         style: AppStyles.primaryButtonText,
                //       ),
                //       Icon(
                //         Icons.chevron_right_rounded,
                //         size: 24,
                //         color: AppColors.lightBlack,
                //       ),
                //     ],
                //   ),
                // ),
                if (!trainingComplete) const SizedBox(height: 15),
                SizedBox(
                  height: trainingComplete
                      ? SizeConfig.screenHeight - 106
                      : SizeConfig.screenHeight - 165,
                  child: AnimatedSwitcher(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    child: DaysList(
                      key: ValueKey<int>(currentLevel),
                      level: Constants.levels[currentLevel].days,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: LevelsList(
              viewPortFraction: 0.9, setCurrentLevel: setCurrentLevel),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(34, 25, 34, 0),
          child: Column(
            children: [
              if (!trainingComplete)
                PrimaryButton(
                  onPressed: () => continueTraining(context),
                  text: "Continue",
                ),
              //   ElevatedButton(
              //   onPressed: () {
              //     continueTraining(context);
              //   },
              //   style: AppStyles.primaryButton,
              //   child: const Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Text(
              //         "Continue",
              //         style: AppStyles.primaryButtonText,
              //       ),
              //       Icon(
              //         Icons.chevron_right_rounded,
              //         size: 24,
              //         color: AppColors.lightBlack,
              //       ),
              //     ],
              //   ),
              // ),
              if (!trainingComplete) SizedBox(height: 25),
              SizedBox(
                height: trainingComplete
                    ? SizeConfig.screenHeight - 338
                    : SizeConfig.screenHeight - (25 + 45 + 150 + 220),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: DaysList(
                    key: ValueKey<int>(currentLevel),
                    level: Constants.levels[currentLevel].days,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
