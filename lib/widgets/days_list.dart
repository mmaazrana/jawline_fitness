import 'package:flutter/material.dart';

import 'day_card.dart';

class DaysList extends StatefulWidget {
  const DaysList({super.key});

  @override
  _DaysListState createState() => _DaysListState();
}

class _DaysListState extends State<DaysList> {
  String? selectedCard;

  void _selectCard(String cardText) {
    setState(() {
      selectedCard = cardText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        final cardText = "Day ${index + 1}";
        final isSelected = selectedCard == cardText;

        return DayCard(
          text: cardText,
          isSelected: isSelected,
          onPressed: () {
            _selectCard(cardText);
          },
        );
      },
    );
  }
}
