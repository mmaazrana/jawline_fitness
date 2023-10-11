
import 'package:hive/hive.dart';
import 'package:jawline_fitness/models/exercise.dart';
part 'day.g.dart'; // This is the generated file

@HiveType(typeId: 0)
class Day extends HiveObject {
  @HiveField(0)
  int number;

  @HiveField(1)
  List<Exercise> exercises;

  @HiveField(2)
  bool isComplete;

  @HiveField(3)
  DateTime completedOn;

  Day({
    required this.number,
    required this.exercises,
    this.isComplete = false,
    DateTime? completedOn,
  }) : completedOn = completedOn ?? DateTime(0);

  void completeDay() {
    isComplete = true;
    completedOn = DateTime.now();
  }

  // Serialization method
  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
      'isComplete': isComplete,
      'completedOn': completedOn.toIso8601String(),
    };
  }

  // Deserialization method
  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      number: json['number'],
      exercises: List<Exercise>.from(json['exercises']
          .map((exerciseJson) => Exercise.fromJson(exerciseJson))),
      isComplete: json['isComplete'],
      completedOn: DateTime.parse(json['completedOn']),
    );
  }
}
