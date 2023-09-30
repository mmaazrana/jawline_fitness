import 'package:flutter/material.dart';
import 'package:jawline_fitness/screens/day_preview.dart';

import '../cards/day_card.dart';

class DaysList extends StatefulWidget {
  final List level;

  const DaysList({super.key, required this.level});

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
      itemCount: widget.level.length,
      itemBuilder: (context, index) {
        final cardText = "Day ${widget.level[index].number}";
        final isSelected = selectedCard == cardText;
        return DayCard(
          currentDay: widget.level[index].number - 1,
          text: cardText,
          isSelected: isSelected,
          onStart: () => {
            Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
              return DayPreview(day: widget.level[index].number);
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
