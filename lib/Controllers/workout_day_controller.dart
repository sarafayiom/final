import 'package:get/get.dart';
import 'package:homeworkout_flutter/Models/muscles_model.dart';
import 'package:homeworkout_flutter/Models/warm_up_model.dart';
import 'package:homeworkout_flutter/Models/workout_day_model.dart';
import 'package:homeworkout_flutter/Services/api_workout_day.dart';



class WorkoutDayController extends GetxController {
  final ApiWorkoutDay _apiWorkoutDay = ApiWorkoutDay();
  var workoutDay = Rxn<WorkOutDayModel>();
  var muscle = Rxn<MuscleModel>();
   var exercisesPyType = Rxn<WarmupModel>();
  RxString errorMessage = ''.obs;


 Future<bool> startchallenge(int idchallenge) async {
  try {
    return await _apiWorkoutDay.startchallenge();
  } catch (e) {
    print('Error: $e');
    return false;
  }
}


  Future<void> fetchWorkoutDay(int dayId,int idchallenge) async {
    try {
      final result1 = await _apiWorkoutDay.getdaydetails(id: dayId, idchallenge: idchallenge, );
      workoutDay.value = result1 as WorkOutDayModel?;
    } catch (e) {
      errorMessage.value = e.toString();
      print('WorkoutDayController Error: $e');
    }
  }

  Future<void> fetchMuscleExercises(int muscleId) async {
    try {
      final result = await _apiWorkoutDay.getmuscledetails(id: muscleId);
      muscle.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
      print('WorkoutDayController Error: $e');
    }
  }
   Future<void> fetchwarmupExercises(String type) async {
    try {
      final result = await _apiWorkoutDay.getwarmupexercises(type: type);
      exercisesPyType.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
      print('WorkoutDayController Error: $e');
    }
  }
}