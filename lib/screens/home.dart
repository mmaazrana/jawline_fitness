import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/widgets/settings_page.dart';

import '../utils/size_config.dart';
import '../widgets/app_title.dart';
import '../widgets/reports_page.dart';
import '../widgets/training_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig().init(context);
  }

  final List<Widget> _pages = const [
    TrainingPage(),
    ReportsPage(),
    SettingsPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  int _selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isLandscape = SizeConfig.orientation == Orientation.landscape ||
        SizeConfig.screenWidth > 720;

    final bottomNavigationBar = BottomNavigationBar(
      backgroundColor: AppColors.lightBlack,
      selectedItemColor: AppColors.yellow,
      unselectedItemColor: AppColors.grey,
      currentIndex: _selectedItemIndex,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      onTap: _onTabTapped,
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

    if (isLandscape) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.lightBlack,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const AppTitle(),
        ),
        backgroundColor: AppColors.lightBlack,
        body: Row(
          children: [
            Container(
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
            ),
            SizedBox(
              width: SizeConfig.screenWidth - 125,
              child: _pages[_selectedItemIndex],
            ),
          ],
        ),
        bottomNavigationBar: const SizedBox
            .shrink(), // Hide the bottom navigation bar in landscape mode
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.lightBlack,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const AppTitle(),
        ),
        backgroundColor: AppColors.lightBlack,
        body: _pages[_selectedItemIndex],
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
            child: bottomNavigationBar,
          ),
        ),
      );
    }
  }

  Widget _buildNavItem(IconData iconData, String text, int index) {
    final isSelected = index == _selectedItemIndex;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
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
