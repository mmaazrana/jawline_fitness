import 'package:flutter/material.dart';
import 'package:jawline_fitness/widgets/cards/toggle_card.dart';

import '../utils/colors.dart';

class VibrationControl extends StatelessWidget {
  const VibrationControl({super.key});

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
      body: const Padding(
        padding: EdgeInsets.fromLTRB(42, 0, 42, 0),
        child: SingleChildScrollView(
          child: Column(children: [
            ToggleCard(),
          ]),
        ),
      ),
    );
    ;
  }
}
