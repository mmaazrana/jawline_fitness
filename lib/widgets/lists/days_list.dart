import 'package:flutter/material.dart';
import 'package:jawline_fitness/screens/day_preview.dart';

import '../cards/day_card.dart';
import '../cards/native_ad_card.dart';

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
    List<dynamic> modifiedList = [];

    for (int i = 0; i < widget.level.length; i++) {
      final cardText = "Day ${widget.level[i].number}";
      final isSelected = selectedCard == cardText;

      // Create a DayCard for the current day
      DayCard dayCard = DayCard(
        currentDay: widget.level[i].number - 1,
        text: cardText,
        isSelected: isSelected,
        onStart: () => {
          Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
            return DayPreview(day: widget.level[i].number);
          })),
        },
        onPressed: () {
          _selectCard(cardText);
        },
      );

      modifiedList.add(dayCard);

      // Insert an ad card after every 5 days
      if ((i + 1) % 5 == 0 && i != widget.level.length - 1) {
        modifiedList.add(const NativeAdCard());
      }
    }

    return ListView.builder(
      itemCount: modifiedList.length,
      cacheExtent: 1,
      clipBehavior: Clip.antiAlias,
      itemBuilder: (context, index) {
        return modifiedList[index];
      },
    );
  }
}
