import 'package:flutter/material.dart';
import 'package:jawline_fitness/utils/constants.dart';
import 'package:jawline_fitness/widgets/cards/exercise_card.dart';

import '../cards/day_card.dart';

class ExercisesList extends StatefulWidget {
  final int day;
  const ExercisesList({super.key, required this.day});

  @override
  ExercisesListState createState() => ExercisesListState();
}

class ExercisesListState extends State<ExercisesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Constants.level[widget.day].length,
      itemBuilder: (context, index) {
        return ExerciseCard(
          title: Constants.level[widget.day][index].title,
          duration: Constants.level[widget.day][index].duration,
          onPressed: () {},
        );
      },
    );
  }
}