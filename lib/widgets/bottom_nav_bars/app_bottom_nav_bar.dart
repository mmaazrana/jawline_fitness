import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final void Function(int index) onTap;
  final int selectedItemIndex;

  const AppBottomNavigationBar({
    super.key,
    required this.selectedItemIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.lightBlack,
      selectedItemColor: AppColors.yellow,
      unselectedItemColor: AppColors.grey,
      currentIndex: selectedItemIndex,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      onTap: onTap,
      enableFeedback: true,
      iconSize: 24,
      showUnselectedLabels: false,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      items: const [
        BottomNavigationBarItem(
          backgroundColor: AppColors.lightBlack,
          icon: Icon(
            Icons.fitness_center_outlined,
          ),
          label: 'Training',
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColors.lightBlack,
          icon: Icon(
            Icons.bar_chart_outlined,
          ),
          label: 'Reports',
        ),
        BottomNavigationBarItem(
          backgroundColor: AppColors.lightBlack,
          icon: Icon(
            Icons.person_2,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
