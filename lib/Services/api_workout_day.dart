import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/Models/muscles_model.dart';
import 'package:homeworkout_flutter/Models/warm_up_model.dart';
import 'package:homeworkout_flutter/Models/workout_day_model.dart';

class ApiWorkoutDay {
  final Dio _dio = Dio();
  final box = GetStorage();
  Future<bool> startchallenge() async {
    final token = box.read('access_token');
    final idchallenge = box.read('id_user_challenge');
    try {
      final response = await _dio.post(
        'http://91.144.22.63:4567/boss/start-challenge/$idchallenge/',
        data: {},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Challenge started: ${response.data}");
        return true;
      } else if (response.statusCode == 400) {
        print("Server says: ${response.data['error']}");

        return false;
      } else {
        print("Unexpected status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print(" Error starting challenge: $e");
      return false;
    }
  }

  Future<WorkOutDayModel> getdaydetails(
      {required int id, required int idchallenge}) async {
    final token = box.read("access_token");
    print(idchallenge);

    try {
      final response = await _dio.get(
        'http://91.144.22.63:4567/boss/challenges/$idchallenge/day/$id/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        WorkOutDayModel dayexercise = WorkOutDayModel.fromMap(response.data);
        final idexercise =
            dayexercise.exercises.map((e) => e.dayExerciseId).toList();
        box.write('idexercise', idexercise);
        print(response.data);
        return dayexercise;
      } else {
        throw Exception("Failed to load workout day data");
      }
    } catch (e) {
      throw Exception("Error fetching workout day: $e");
    }
  }

  Future<MuscleModel> getmuscledetails({required int id}) async {
    final token = box.read("access_token");
    try {
      final response = await _dio.get(
        'http://91.144.22.63:4567/boss/muscle/$id/exercises/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print(const JsonEncoder.withIndent('  ').convert(response.data));

        MuscleModel muscleExercise = MuscleModel.fromMap(response.data);
        final idexercise = muscleExercise.exercises.map((e) => e.id).toList();
        box.write('idexercise', idexercise);

        print(response.data);
        return muscleExercise;
      } else {
        throw Exception("Failed to load muscle exercises");
      }
    } catch (e) {
      throw Exception("Error fetching muscle exercises: $e");
    }
  }

  Future<WarmupModel> getwarmupexercises({required String type}) async {
    final token = box.read("access_token");
    try {
      final response = await _dio.get(
        'http://workout.ofc.com.sy:4567/boss/exercises-by-type/?type=$type',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print(const JsonEncoder.withIndent('  ').convert(response.data));

        WarmupModel typeExercise = WarmupModel.fromMap(response.data);
        final idexercise = typeExercise.exercises!.map((e) => e.id).toList();
        box.write('idexercise', idexercise);

        print(response.data);
        return typeExercise;
      } else {
        throw Exception("Failed to load muscle exercises");
      }
    } catch (e) {
      throw Exception("Error fetching muscle exercises: $e");
    }
  }
}