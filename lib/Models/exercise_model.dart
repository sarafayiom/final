import 'dart:convert';

ExerciseDetailModel exerciseDetailModelFromMap(String str) => ExerciseDetailModel.fromMap(json.decode(str));

String exerciseDetailModelToMap(ExerciseDetailModel data) => json.encode(data.toMap());

class ExerciseDetailModel {
    int dayExerciseId;
    Exercise exercise;

    ExerciseDetailModel({
        required this.dayExerciseId,
        required this.exercise,
    });

    factory ExerciseDetailModel.fromMap(Map<String, dynamic> json) => ExerciseDetailModel(
        dayExerciseId: json["day_exercise_id"],
        exercise: Exercise.fromMap(json["exercise"]),
    );

    Map<String, dynamic> toMap() => {
        "day_exercise_id": dayExerciseId,
        "exercise": exercise.toMap(),
    };
}

class Exercise {
    int id;
    String name;
    String description;
    String goal;
    String type;
    int repetitions;
    int durationSeconds;
    int caloriesBurned;
    String image;

    Exercise({
       required this.id,
         required this.name,
        required this.description,
         required this.goal,
        required this.type,
        required this.repetitions,
        required this.durationSeconds,
        required this.caloriesBurned,
        required this.image,
    });

    factory Exercise.fromMap(Map<String, dynamic> json) => Exercise(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        goal: json["goal"],
        type: json["type"],
        repetitions: json["repetitions"],
        durationSeconds: json["duration_seconds"],
        caloriesBurned: json["calories_burned"],
        image: json["image"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "goal": goal,
        "type": type,
        "repetitions": repetitions,
        "duration_seconds": durationSeconds,
        "calories_burned": caloriesBurned,
        "image": image,
    };
}
