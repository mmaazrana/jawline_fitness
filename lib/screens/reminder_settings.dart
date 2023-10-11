import 'package:flutter/material.dart';
import 'package:jawline_fitness/widgets/cards/toggle_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors.dart';

class ReminderSettings extends StatefulWidget {
  const ReminderSettings({super.key});

  @override
  State<ReminderSettings> createState() => _ReminderSettingsState();
}

class _ReminderSettingsState extends State<ReminderSettings> {
  late bool loopAudio = true;
  late bool showNotification = true;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool showNotificationData = prefs.getBool("showNotification") ?? true;
    bool loopAudioData = prefs.getBool("loopAudio") ?? true;
    setState(() {
      showNotification = showNotificationData;
      loopAudio = loopAudioData;
    });
  }

  void toggleNotification(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      showNotification = value;
    });
    prefs.setBool('showNotification', showNotification);
  }

  void toggleAudioLoop(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loopAudio = value;
    });
    prefs.setBool('loopAudio', loopAudio);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: AppBar(
        title: const Text(
          "REMINDER SETTINGS",
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(42, 24, 42, 0),
        child: SingleChildScrollView(
          child: Column(children: [
            ToggleCard(
              text: "Reminder Notification",
              value: showNotification,
              onToggle: toggleNotification,
            ),
            const SizedBox(height: 15),
            ToggleCard(
              text: "Loop Reminder Audio",
              value: loopAudio,
              onToggle: toggleAudioLoop,
            ),
          ]),
        ),
      ),
    );
  }
}
