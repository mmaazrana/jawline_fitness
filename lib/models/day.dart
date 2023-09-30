import 'package:jawline_fitness/models/exercise.dart';

class Day {
  final int number;
  final List<Exercise> exercises;
  bool isComplete = false;
  late final DateTime _completedOn;

  Day({
    required this.number,
    required this.exercises,
  });

  void completeDay() {
    isComplete = true;
    _completedOn = DateTime.now();
  }

  DateTime getCompletedOn() {
    if (isComplete) {
      return _completedOn;
    } else {
      throw "Day Not Completed Yet";
    }
  }
}
