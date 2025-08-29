class UserBasicInfoModel {
  String gender;
  String dateofbirth;
  int weight;
  int height;
  int goalweight;
  UserBasicInfoModel({
    required this.gender,
    required this.dateofbirth,
    required this.weight,
    required this.height,
    required this.goalweight,
  });

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'date_of_birth': dateofbirth,
      'height': height,
      'weight': weight,
      'weight_goal' :goalweight,
    };
  }
}
