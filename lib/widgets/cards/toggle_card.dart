import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../switches/custom_switch.dart';

class ToggleCard extends StatelessWidget {
  final String text;
  final bool value;
  final void Function(bool value) onToggle;
  const ToggleCard({
    super.key,
    required this.text,
    required this.value,
    required this.onToggle,
  });

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const Spacer(),
          CustomSwitch(
            reminder: value,
            onEnable: () => onToggle(true),
            onDisable: () => onToggle(false),
          )
        ],
      ),
    );
  }
}
