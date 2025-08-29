import 'package:get/get.dart';
import 'package:homeworkout_flutter/Models/exercises_by_type.dart';
import 'package:homeworkout_flutter/Services/api_exercise_detail.dart';
import 'package:homeworkout_flutter/models/exercise_model.dart';

class ExercisesController extends GetxController{
  final ApiExerciseDetail _apiExerciseDetail = ApiExerciseDetail();

var exerciseDetail = Rxn<ExerciseDetailModel>();
var exercisebytype = Rxn<ExercisesbytypeModel>();
  RxString errorMessage = ''.obs;


 Future<vint exerciseIdoid> fetchExerciseDetail(int exerciseId) async {
  try {
    errorMessage.value = '';

    final result = await _apiExerciseDetail.getexercisedetail(exerciseId);
    exerciseDetail.value = result as ExerciseDetailModel?;
  } catch (e) {
    errorMessage.value = e.toString();
    print('ExercisesController Error: $e');
  }
}

Future<void> fetchExercise(int exerciseId) async {
  try {
    errorMessage.value = '';

    final result = await _apiExerciseDetail.getexercisesbytype(exerciseId);
    exercisebytype.value = result;
  } catch (e) {
    errorMessage.value = e.toString();
    print('ExercisesController Error: $e');
  }
}


}