import 'package:hive/hive.dart';

part 'exercise.g.dart'; // This is the generated file

@HiveType(typeId: 1) // Use a different typeId from the Day class
class Exercise extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final List<String> steps;

  @HiveField(3)
  final int duration;

  Exercise({
    required this.title,
    required this.description,
    required this.steps,
    required this.duration,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'steps': steps,
      'duration': duration,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      title: json['title'],
      description: json['description'],
      steps: List<String>.from(json['steps']),
      duration: json['duration'],
    );
  }
}
