class UserMoreDetailsModel {
  String goal;
  String level;
  List<int> musclegroups;
  UserMoreDetailsModel({
    required this.goal,
    required this.musclegroups,
     required this.level,
  });

  Map<String, dynamic> toJson() {
    return {
      'goal': goal,
      'focused_muscle_groups': musclegroups,
      'level': level,
    };
  }
}
