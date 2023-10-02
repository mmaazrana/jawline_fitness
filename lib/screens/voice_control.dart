import 'package:flutter/material.dart';
import 'package:jawline_fitness/widgets/cards/toggle_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors.dart';

class VoiceControl extends StatefulWidget {
  const VoiceControl({super.key});

  @override
  State<VoiceControl> createState() => _VoiceControlState();
}

class _VoiceControlState extends State<VoiceControl> {
  late bool isVoiceEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isVoiceEnabledData = prefs.getBool('isVoiceEnabled') ?? true;
    setState(() {
      isVoiceEnabled = isVoiceEnabledData;
    });
  }

  void toggleVoice(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isVoiceEnabled = value;
    });
    prefs.setBool('isVoiceEnabled', isVoiceEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: AppBar(
        title: const Text(
          "VOICE CONTROL",
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
              text: "Voice Guidance",
              value: isVoiceEnabled,
              onToggle: toggleVoice,
            ),
          ]),
        ),
      ),
    );
    ;
  }
}
