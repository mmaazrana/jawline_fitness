import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class CustomSwitch extends StatelessWidget {
  final bool reminder;
  final void Function() onEnable;
  final void Function() onDisable;

  const CustomSwitch({
    super.key,
    required this.reminder,
    required this.onEnable,
    required this.onDisable,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: reminder,
      trackOutlineColor: MaterialStateProperty.all(
        reminder ? AppColors.yellow : AppColors.grey,
      ),
      thumbIcon: MaterialStateProperty.all(
        const Icon(
          Icons.circle,
          color: AppColors.darkGrey,
        ),
      ),
      inactiveThumbColor: AppColors.grey,
      inactiveTrackColor: AppColors.darkGrey,
      activeTrackColor: AppColors.darkGrey,
      focusColor: AppColors.yellow,
      hoverColor: AppColors.yellow,
      activeColor: AppColors.yellow,
      overlayColor: MaterialStateProperty.all(
        AppColors.yellow,
      ),
      onChanged: (bool value) {
        if (value) {
          onEnable();
        } else {
          onDisable();
        }
      },
    );
  }
}
