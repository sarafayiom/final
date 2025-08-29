import 'dart:convert';

WorkOutDayModel workOutDayModelFromMap(String str) =>
    WorkOutDayModel.fromMap(json.decode(str));

String workOutDayModelToMap(WorkOutDayModel data) => json.encode(data.toMap());

class WorkOutDayModel {

  int dayNumber;
  double totalDurationMinutes;
  int totalExercises;
  List<Exercise> exercises;

  WorkOutDayModel({
    required this.dayNumber,
    required this.totalDurationMinutes,
    required this.totalExercises,
    required this.exercises,
  });

  factory WorkOutDayModel.fromMap(Map<String, dynamic> json) => WorkOutDayModel(
        dayNumber: json["day_number"],
        totalDurationMinutes: json["total_duration_minutes"]?.toDouble(),
        totalExercises: json["total_exercises"],
        exercises: List<Exercise>.from(
            json["exercises"].map((x) => Exercise.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "day_number": dayNumber,
        "total_duration_minutes": totalDurationMinutes,
        "total_exercises": totalExercises,
        "exercises": List<dynamic>.from(exercises.map((x) => x.toMap())),
      };
}

class Exercise {
  int dayExerciseId;
  String name;
  String image;
  int repetitions;

  Exercise({
    required this.dayExerciseId,
    required this.name,
    required this.image,
    required this.repetitions,
  });

  factory Exercise.fromMap(Map<String, dynamic> json) => Exercise(
        dayExerciseId: json["day_exercise_id"],
        name: json["name"],
        image: json["image"],
        repetitions: json["repetitions"],
      );

  Map<String, dynamic> toMap() => {
        "day_exercise_id": dayExerciseId,
        "name": name,
        "image": image,
        "repetitions": repetitions,
      };
}
