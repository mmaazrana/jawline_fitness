import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/size_config.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/utils/svg_assets.dart';
import '../widgets/alarm_card.dart';
import '../widgets/exercise_app_bar.dart';

class ExcerciseCompleteScreen extends StatefulWidget {
  const ExcerciseCompleteScreen({super.key});

  @override
  State<ExcerciseCompleteScreen> createState() =>
      _ExcerciseCompleteScreenState();
}

class _ExcerciseCompleteScreenState extends State<ExcerciseCompleteScreen> {
  final int day = 1;

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
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 50),
          SvgAssets.createLineSvg(
            SvgAssets.line1,
            SizeConfig.screenWidth,
            SizeConfig.screenHeight,
          ),
          const SizedBox(height: 50),
          const Text(
            "Day Complete",
            style: AppStyles.alternateHeading,
          ),
          const SizedBox(height: 75),
          const Padding(
            padding: EdgeInsets.fromLTRB(22, 0, 22, 0),
            child: AlarmCard(
              alarmSettings: null,
            ),
          ),
          const SizedBox(height: 75),
          Padding(
            padding: const EdgeInsets.fromLTRB(42, 0, 42, 42),
            child: ElevatedButton(
              onPressed: () {},
              style: AppStyles.primaryButton,
              child: const Text(
                "Done",
                style: AppStyles.primaryButtonText,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
