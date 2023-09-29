import 'package:flutter/material.dart';
import 'package:jawline_fitness/screens/day_preview.dart';
import 'package:jawline_fitness/utils/constants.dart';
import 'package:jawline_fitness/utils/routes.dart';

import '../cards/day_card.dart';

class DaysList extends StatefulWidget {
  const DaysList({super.key});

  @override
  DaysListState createState() => DaysListState();
}

class DaysListState extends State<DaysList> {
  String? selectedCard;

  void _selectCard(String cardText) {
    setState(() {
      selectedCard = cardText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Constants.levelOne.length,
      itemBuilder: (context, index) {
        final cardText = "Day ${index + 1}";
        final isSelected = selectedCard == cardText;
        return DayCard(
          text: cardText,
          isSelected: isSelected,
          onStart: () => {
            Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
              return DayPreview(day: index + 1);
            })),
          },
          onPressed: () {
            _selectCard(cardText);
          },
        );
      },
    );
  }
}
