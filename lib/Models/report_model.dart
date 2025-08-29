class ReportModel {
  final double totalCalories;
  final double totalMinutes;
  final String bmi;

  ReportModel({
    required this.totalCalories,
    required this.totalMinutes,
    required this.bmi,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      totalCalories: (json["total_calories"] ?? 0).toDouble(),
      totalMinutes: (json["total_minutes"] ?? 0).toDouble(),
      bmi: json["bmi"] ?? "",
    );
  }
  double get bmiValue {
    return double.tryParse(bmi.split(" ")[0]) ?? 0;
  }
}