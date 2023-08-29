import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';
import 'package:jawline_fitness/widgets/home_pages/settings_page.dart';

import '../utils/size_config.dart';
import '../widgets/app_bars/app_title_bar.dart';
import '../widgets/bottom_nav_bars/app_bottom_nav_bar.dart';
import '../widgets/home_pages/reports_page.dart';
import '../widgets/home_pages/training_page.dart';
import '../widgets/side_bars/app_side_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedItemIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    if (SizeConfig.isLandscape) {
      return _buildLandscapeLayout();
    } else {
      return _buildPortraitLayout();
    }
  }

  Scaffold _buildPortraitLayout() {
    return Scaffold(
      appBar: const AppTitleBar(),
      backgroundColor: AppColors.lightBlack,
      body: _pages[_selectedItemIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
          child: AppBottomNavigationBar(
            selectedItemIndex: _selectedItemIndex,
            onTap: _onTabTapped,
          ),
        ),
      ),
    );
  }

  Scaffold _buildLandscapeLayout() {
    return Scaffold(
      appBar: const AppTitleBar(),
      backgroundColor: AppColors.lightBlack,
      body: Row(
        children: [
          AppSideBar(
            selectedItemIndex: _selectedItemIndex,
            onTap: _onTabTapped,
          ),
          SizedBox(
            width: SizeConfig.screenWidth - 125,
            child: _pages[_selectedItemIndex],
          ),
        ],
      ),
    );
  }
}
