import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/Models/exercises_by_type.dart';
import 'package:homeworkout_flutter/models/exercise_model.dart';

class ApiExerciseDetail {
  final Dio _dio = Dio();
  final box = GetStorage();
  Future<ExerciseDetailModel> getexercisedetail(int id) async {
    final token = box.read("access_token");
 
    try {
      Response response = await _dio.get(
        'http://91.144.22.63:4567/boss/get-exercise-day/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        ExerciseDetailModel exerciseDetail =
            ExerciseDetailModel.fromMap(response.data);
        print(response.data);
        return exerciseDetail;
      } else {
        throw Exception("Failed to load execises day data");
      }
    } catch (e) {
      throw Exception("Error fetching exercises day: $e");
    }
  }

  Future<ExercisesbytypeModel> getexercisesbytype(int id) async {
    final token = box.read("access_token");
    //final idexercise = box.read('idexercise');
    try {
      Response response = await _dio.get(
        'http://91.144.22.63:4567/boss/exercise/$id/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        ExercisesbytypeModel exercise2 =
           ExercisesbytypeModel.fromMap(response.data);
        print(response.data);
        return exercise2;
      } else {
        throw Exception("Failed to load execises day data");
      }
    } catch (e) {
      throw Exception("Error fetching exercises day: $e");
    }
  }
}