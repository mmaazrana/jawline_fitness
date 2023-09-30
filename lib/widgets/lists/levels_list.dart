import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/colors.dart';

import '../../utils/constants.dart';
import '../cards/progress_card.dart';

class LevelsList extends StatefulWidget {
  final double viewPortFraction;
  final void Function(int selectedIndex) setCurrentLevel;
  const LevelsList({
    super.key,
    required this.viewPortFraction,
    required this.setCurrentLevel,
  });

  @override
  State<LevelsList> createState() => _LevelsListState();
}

class _LevelsListState extends State<LevelsList> {
  late final PageController _pageController;
  bool showThreeDotsIndicator = false;
  int currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      // Set the viewportFraction to control visibility of adjacent cards
      viewportFraction: widget.viewPortFraction,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bool isLandscape =
          MediaQuery.of(context).orientation == Orientation.landscape;
      final double screenWidth = MediaQuery.of(context).size.width;
      showThreeDotsIndicator = isLandscape || screenWidth > 720;
      setState(() {});

      _pageController.addListener(() {
        setState(() {
          currentPageIndex = _pageController.page?.round() ?? 0;
          widget.setCurrentLevel(currentPageIndex);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _pageController,
            itemCount: Constants.levels.length,
            itemBuilder: (context, index) {
              final cardData = Constants.levels[index];
              return ProgressCard(
                heading: "Level ${index + 1}",
                description: cardData.difficulty,
                progress: 0.8,
              );
            },
          ),
        ),
        if (showThreeDotsIndicator)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < Constants.levels.length; i++)
                  if (i == currentPageIndex)
                    _buildDotIndicator(true)
                  else
                    _buildDotIndicator(false),
              ],
            ),
          ),
      ],
    );
  }
}

Widget _buildDotIndicator(bool isActive) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      width: isActive ? 10 : 6,
      height: isActive ? 10 : 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.yellow : AppColors.darkGrey,
      ),
    ),
  );
}

// List<Map<String, dynamic>> cardsData = [
//   {
//     'heading': 'Level 1',
//     'description': 'Beginner',
//     'progress': 0.75,
//   },
//   {
//     'heading': 'Level 2',
//     'description': 'Intermediate',
//     'progress': 0.5,
//   },
//   {
//     'heading': 'Level 3',
//     'description': 'Expert',
//     'progress': 0.3,
//   },
//   // Add more cards as needed
// ];
