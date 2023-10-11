import 'package:flutter/material.dart';
import 'package:jawline_fitness/widgets/cards/toggle_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors.dart';

class VibrationControl extends StatefulWidget {
  const VibrationControl({super.key});

  @override
  State<VibrationControl> createState() => _VibrationControlState();
}

class _VibrationControlState extends State<VibrationControl> {
  late bool isVibrationEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isVibrationEnabledData = prefs.getBool('isVibrationEnabled') ?? true;
    setState(() {
      isVibrationEnabled = isVibrationEnabledData;
    });
  }

  void toggleVibration(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isVibrationEnabled = value;
    });
    prefs.setBool('isVibrationEnabled', isVibrationEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: AppBar(
        title: const Text(
          "VIBRATION CONTROL",
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
              text: "Vibration Feedback",
              value: isVibrationEnabled,
              onToggle: toggleVibration,
            ),
          ]),
        ),
      ),
    );
  }
}
