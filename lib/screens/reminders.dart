import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/widgets/cards/alarm_card.dart';

class CustomReminders extends StatelessWidget {
  const CustomReminders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: AppBar(
        title: const Text(
          "REMINDERS",
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
      body: const Padding(
        padding: EdgeInsets.fromLTRB(42, 0, 42, 0),
        child: SingleChildScrollView(
          child: Column(children: [
            AlarmCard(),
            AlarmCard(),
            AlarmCard(),
          ]),
        ),
      ),
    );
  }
}
