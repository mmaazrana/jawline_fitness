import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/size_config.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/widgets/buttons/secondary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/buttons/primary_button.dart';

class AlarmRingScreen extends StatefulWidget {
  final AlarmSettings alarmSettings;

  const AlarmRingScreen({Key? key, required this.alarmSettings}) : super(key: key);

  @override
  State<AlarmRingScreen> createState() => _AlarmRingScreenState();
}

class _AlarmRingScreenState extends State<AlarmRingScreen> {
  late SharedPreferences prefs;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: AppBar(
        title: const Text(
          "REMINDER",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.lightBlack,
        foregroundColor: AppColors.grey,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 32,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizeConfig.isLandscape
              ? _buildLandscapeLayout(context)
              : _buildPortraitLayout(context),
        ),
      ),
    );
  }

  Padding _buildPortraitLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Daily Jaw Training Reminder",
            style: AppStyles.secondaryHeading,
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: SizeConfig.screenHeight * 0.45,
            child: SvgPicture.asset(
              "assets/reminder.svg",
            ),
          ),
          const SizedBox(height: 24),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryButton(
                onPressed: () {
                  final now = DateTime.now();
                  final updatedDate = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    now.hour,
                    now.minute,
                    0,
                    0,
                  ).add(
                    const Duration(days: 1),
                  );
                  Alarm.set(
                    alarmSettings: widget.alarmSettings.copyWith(
                      dateTime: updatedDate,
                    ),
                  ).then((_) async => {
                        prefs = await SharedPreferences.getInstance(),
                        prefs.setInt("year", updatedDate.year),
                        prefs.setInt("month", updatedDate.month),
                        prefs.setInt("day", updatedDate.day),
                        prefs.setInt("hour", updatedDate.hour),
                        prefs.setInt("minute", updatedDate.minute),
                        Navigator.pop(context),
                      });
                },
                text: "Stop",
                hasIcon: false,
              ),
              const SizedBox(height: 24),
              SecondaryButton(
                onPressed: () {
                  final now = DateTime.now();
                  final updatedDate = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    now.hour,
                    now.minute,
                    0,
                    0,
                  ).add(
                    const Duration(minutes: 1),
                  );
                  Alarm.set(
                    alarmSettings: widget.alarmSettings.copyWith(
                      dateTime: updatedDate,
                    ),
                  ).then((_) async => {
                        prefs = await SharedPreferences.getInstance(),
                        prefs.setInt("year", updatedDate.year),
                        prefs.setInt("month", updatedDate.month),
                        prefs.setInt("day", updatedDate.day),
                        prefs.setInt("hour", updatedDate.hour),
                        prefs.setInt("minute", updatedDate.minute),
                        Navigator.pop(context),
                      });
                },
                text: "Snooze",
                hasIcon: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _buildLandscapeLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.65,
            child: SvgPicture.asset(
              "assets/reminder.svg",
            ),
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Daily Jaw \nTraining Reminder",
                style: AppStyles.secondaryHeading,
              ),
              const SizedBox(height: 32),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryButton(
                    onPressed: () {
                      final now = DateTime.now();
                      final updatedDate = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        now.hour,
                        now.minute,
                        0,
                        0,
                      ).add(
                        const Duration(days: 1),
                      );
                      Alarm.set(
                        alarmSettings: widget.alarmSettings.copyWith(
                          dateTime: updatedDate,
                        ),
                      ).then((_) async => {
                            prefs = await SharedPreferences.getInstance(),
                            prefs.setInt("year", updatedDate.year),
                            prefs.setInt("month", updatedDate.month),
                            prefs.setInt("day", updatedDate.day),
                            prefs.setInt("hour", updatedDate.hour),
                            prefs.setInt("minute", updatedDate.minute),
                            Navigator.pop(context),
                          });
                    },
                    text: "Stop",
                    hasIcon: false,
                  ),
                  const SizedBox(height: 24),
                  SecondaryButton(
                    onPressed: () {
                      final now = DateTime.now();
                      final updatedDate = DateTime(
                        now.year,
                        now.month,
                        now.day,
                        now.hour,
                        now.minute,
                        0,
                        0,
                      ).add(
                        const Duration(minutes: 1),
                      );
                      Alarm.set(
                        alarmSettings: widget.alarmSettings.copyWith(
                          dateTime: updatedDate,
                        ),
                      ).then((_) async => {
                            prefs = await SharedPreferences.getInstance(),
                            prefs.setInt("year", updatedDate.year),
                            prefs.setInt("month", updatedDate.month),
                            prefs.setInt("day", updatedDate.day),
                            prefs.setInt("hour", updatedDate.hour),
                            prefs.setInt("minute", updatedDate.minute),
                            Navigator.pop(context),
                          });
                    },
                    text: "Snooze",
                    hasIcon: false,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
