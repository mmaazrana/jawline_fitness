import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/utils/styles.dart';
import 'package:jawline_fitness/widgets/buttons/secondary_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/buttons/primary_button.dart';

class AlarmRingScreen extends StatelessWidget {
  final AlarmSettings alarmSettings;

  AlarmRingScreen({Key? key, required this.alarmSettings}) : super(key: key);

  late SharedPreferences prefs;

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
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Daily Jaw Training Reminder",
                style: AppStyles.secondaryHeading,
              ),
              const SizedBox(height: 24),
              const Text("Illustration", style: TextStyle(fontSize: 50)),
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
                        alarmSettings: alarmSettings.copyWith(
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
                        alarmSettings: alarmSettings.copyWith(
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
        ),
      ),
    );
  }
}
