import 'dart:convert';

UserChallengeModel userChallengeModelFromMap(String str) =>
    UserChallengeModel.fromMap(json.decode(str));

String userChallengeModelToMap(UserChallengeModel data) =>
    json.encode(data.toMap());

class UserChallengeModel {
  UserChallenge? userChallenge;
  List<PublicChallenge>? publicChallenges;

  UserChallengeModel({this.userChallenge, this.publicChallenges});

  factory UserChallengeModel.fromMap(Map<String, dynamic> json) =>
      UserChallengeModel(
        userChallenge: json["user_challenge"] == null
            ? null
            : UserChallenge.fromMap(json["user_challenge"]),
        publicChallenges: json["public_challenges"] == null
            ? []
            : List<PublicChallenge>.from(
                json["public_challenges"].map(
                  (x) => PublicChallenge.fromMap(x),
                ),
              ),
      );

  Map<String, dynamic> toMap() => {
    "user_challenge": userChallenge?.toMap(),
    "public_challenges": publicChallenges == null
        ? []
        : List<dynamic>.from(publicChallenges!.map((x) => x.toMap())),
  };
}

class PublicChallenge {
  int? id;
  String? name;
  int? durationWeeks;
  String? level;

  PublicChallenge({this.id, this.name, this.durationWeeks, this.level});

  factory PublicChallenge.fromMap(Map<String, dynamic> json) => PublicChallenge(
    id: json["id"],
    name: json["name"],
    durationWeeks: json["duration_weeks"],
    level: json["level"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "duration_weeks": durationWeeks,
    "level": level,
  };
}

class UserChallenge {
  int id;
  String name;

  UserChallenge({required this.id, required this.name});

  factory UserChallenge.fromMap(Map<String, dynamic> json) =>
      UserChallenge(id: json["id"], name: json["name"]);

  Map<String, dynamic> toMap() => {"id": id, "name": name};
}