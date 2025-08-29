
import 'dart:convert';

ExercisesbytypeModel exercisesbytypeModelFromMap(String str) => ExercisesbytypeModel.fromMap(json.decode(str));

String exercisesbytypeModelToMap(ExercisesbytypeModel data) => json.encode(data.toMap());

class ExercisesbytypeModel {
    String name;
    String description;
    String image;
    String type;
    String goal;
    List<int> muscleGroup;
    int baseRepetitions;
    int baseDurationSeconds;
    int baseCaloriesBurned;

    ExercisesbytypeModel({
        required this.name,
        required this.description,
        required this.image,
        required this.type,
        required this.goal,
        required this.muscleGroup,
        required this.baseRepetitions,
        required this.baseDurationSeconds,
        required this.baseCaloriesBurned,
    });

    factory ExercisesbytypeModel.fromMap(Map<String, dynamic> json) => ExercisesbytypeModel(
        name: json["name"],
        description: json["description"],
        image: json["image"],
        type: json["type"],
        goal: json["goal"],
        muscleGroup: List<int>.from(json["muscle_group"].map((x) => x)),
        baseRepetitions: json["base_repetitions"],
        baseDurationSeconds: json["base_duration_seconds"],
        baseCaloriesBurned: json["base_calories_burned"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "description": description,
        "image": image,
        "type": type,
        "goal": goal,
        "muscle_group": List<dynamic>.from(muscleGroup.map((x) => x)),
        "base_repetitions": baseRepetitions,
        "base_duration_seconds": baseDurationSeconds,
        "base_calories_burned": baseCaloriesBurned,
    };
}
