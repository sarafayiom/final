class UserCompleteProfileModel {
  String workouttimeperday;
  List<String> workoutdays;

  UserCompleteProfileModel({
    required this.workoutdays,
    required this.workouttimeperday,
  });

  Map<String, dynamic> toJson() {
    return {
      'workout_days': workoutdays,
      'workout_time_per_day': workouttimeperday,
    };
  }
}