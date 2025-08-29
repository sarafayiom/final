import 'dart:convert';

MuscleModel muscleModelFromMap(String str) => MuscleModel.fromMap(json.decode(str));

String muscleModelToMap(MuscleModel data) => json.encode(data.toMap());

class MuscleModel {
    String muscle;
    double totalduration;
    int totalExercises;
    List<Exercise> exercises;

    MuscleModel({
        required this.muscle,
        required this.totalduration,
        required this.totalExercises,
        required this.exercises,
    });

    factory MuscleModel.fromMap(Map<String, dynamic> json) => MuscleModel(
        muscle: json["muscle"],
        totalduration: json[ "total_duration_minutes"].toDouble(),
        totalExercises: json["total_exercises"],
        exercises: List<Exercise>.from(json["exercises"].map((x) => Exercise.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "muscle": muscle,
        "total_duration_minutes": totalduration,
        "total_exercises": totalExercises,
        "exercises": List<dynamic>.from(exercises.map((x) => x.toMap())),
    };
}

class Exercise {
    int id;
    String name;
    String image;
    int durationSeconds;

    Exercise({
        required this.id,
        required this.name,
        required this.image,
        required this.durationSeconds,
    });

    factory Exercise.fromMap(Map<String, dynamic> json) => Exercise(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        durationSeconds: json["duration_seconds"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "duration_seconds": durationSeconds,
    };
}
