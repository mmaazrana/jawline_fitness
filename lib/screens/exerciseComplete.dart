import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/styles.dart';

import '../utils/size_config.dart';
import '../widgets/alarm_card.dart';

class ExcerciseCompleteScreen extends StatefulWidget {
  const ExcerciseCompleteScreen({super.key});

  @override
  State<ExcerciseCompleteScreen> createState() =>
      _ExcerciseCompleteScreenState();
}

class _ExcerciseCompleteScreenState extends State<ExcerciseCompleteScreen> {
  int day = 1;

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
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50,
          ),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Container(
              width: SizeConfig.screenWidth,
              child: Transform.scale(
                scale: 1.35,
                child: SvgPicture.asset(
                  "assets/line3.svg",
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Day Complete",
            style: TextStyle(
              fontSize: 32,
              color: AppColors.yellow,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(
            height: 75,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
            child: AlarmCard(
              alarmSettings: null,
            ),
          ),
          SizedBox(
            height: 75,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(42, 0, 42, 42),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                "Done",
                style: AppStyles.primaryButtonText,
              ),
              style: AppStyles.primaryButton,
            ),
          ),
        ],
      )),
    );
  }
}
