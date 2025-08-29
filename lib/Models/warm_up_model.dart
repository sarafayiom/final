import 'dart:convert';

WarmupModel warmupModelFromMap(String str) => WarmupModel.fromMap(json.decode(str));

String warmupModelToMap(WarmupModel data) => json.encode(data.toMap());

class WarmupModel {
    List<Exercise>? exercises;
    int ?totaldurationminutes;
    int ?count;

    WarmupModel({
        required this.exercises,
        required this.totaldurationminutes,
        required this.count,
    });

    factory WarmupModel.fromMap(Map<String, dynamic> json) => WarmupModel(
        exercises: List<Exercise>.from(json["exercises"].map((x) => Exercise.fromMap(x))),
        totaldurationminutes: json["total_duration"],
        count: json["count"],
    );

    Map<String, dynamic> toMap() => {
        "exercises": List<dynamic>.from(exercises!.map((x) => x.toMap())),
        "total_duration": totaldurationminutes,
        "count": count,
    };
}

class Exercise {
    int id;
    String name;
    String image;
    int duration;

    Exercise({
        required this.id,
        required this.name,
        required this.image,
        required this.duration,
    });

    factory Exercise.fromMap(Map<String, dynamic> json) => Exercise(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        duration: json["duration"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "image": image,
        "duration": duration,
    };
}
