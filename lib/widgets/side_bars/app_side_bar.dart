import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppSideBar extends StatelessWidget {
  final int selectedItemIndex;
  final void Function(int index) onTap;

  const AppSideBar({
    super.key,
    required this.selectedItemIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.fromLTRB(24, 0, 0, 24),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.darkGrey,
            width: 3,
          )), // Adjust the width as needed
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildNavItem(Icons.fitness_center_outlined, 'Training', 0),
          _buildNavItem(Icons.bar_chart_outlined, 'Reports', 1),
          _buildNavItem(Icons.person_2, 'Profile', 2),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData iconData,
    String text,
    int index,
  ) {
    final isSelected = index == selectedItemIndex;

    return InkWell(
      onTap: () {
        onTap(index);
      },
      highlightColor: Colors.transparent, // Remove splash effect
      splashFactory: NoSplash.splashFactory, // Remove splash effect
      splashColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 20,
              color: isSelected ? AppColors.yellow : AppColors.grey,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                transform: Matrix4.identity()..rotateX(isSelected ? 0 : -1.57),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: AppColors.yellow,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
