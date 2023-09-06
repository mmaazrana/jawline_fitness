import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/colors.dart';
import '../switches/custom_switch.dart';

class ToggleCard extends StatefulWidget {
  const ToggleCard({super.key});

  @override
  State<ToggleCard> createState() => _ToggleCardState();
}

class _ToggleCardState extends State<ToggleCard> {
  late bool isVibrationEnabled;

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
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Row(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Vibration Feedback",
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const Spacer(),
          CustomSwitch(
            reminder: isVibrationEnabled,
            onEnable: () => toggleVibration(true),
            onDisable: () => toggleVibration(false),
          )
        ],
      ),
    );
    ;
  }
}
