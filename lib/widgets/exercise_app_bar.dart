import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ExerciseAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ExerciseAppBar({
    super.key,
    required this.day,
  });

  final int day;

  @override
  Size get preferredSize =>
      Size.fromHeight(80); // Customize the height as needed

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      toolbarHeight: 80,
      leading: Icon(
        Icons.chevron_left_rounded,
        size: 40,
        color: AppColors.grey,
      ),
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_vert_rounded,
            size: 28,
            color: AppColors.grey,
          ),
        ),
        SizedBox(
          width: 20,
        ),
      ],
      title: Text(
        'Day $day',
        style: TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
      backgroundColor: AppColors.lightBlack,
      foregroundColor: AppColors.grey,
    );
  }
}