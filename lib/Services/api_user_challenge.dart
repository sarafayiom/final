
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:homeworkout_flutter/Models/user_challenge_model.dart';
import 'package:homeworkout_flutter/Services/api_refresh_token.dart';

class ApiUserChallenge {
  final Dio _dio = Dio();
  final box = GetStorage();
  final ApiRefreshToken apiRefreshToken = ApiRefreshToken();

  ApiUserChallenge() { _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, ErrorInterceptorHandler handler) async {
          if (e.response?.statusCode == 401) {
            bool refreshed = await apiRefreshToken.refreshToken();
            if (refreshed) {
              final newToken = box.read('access_token');
              final retryRequest = e.requestOptions;
              retryRequest.headers['Authorization'] = 'Bearer $newToken';
              try {
                final cloneResponse = await _dio.fetch(retryRequest);
                return handler.resolve(cloneResponse);
              } catch (err) {
                return handler.reject(err as DioException);
              }
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<UserChallengeModel?> getAllChallenges() async {
    try {
      final token = box.read('access_token');
      final response = await _dio.get(
        'http://91.144.22.63:4567/boss/allchallenges',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final challenges = UserChallengeModel.fromMap(response.data);
       
       final idUserChallenge = challenges.userChallenge?.id;
      if (idUserChallenge != null) {
        box.write('id_user_challenge', idUserChallenge);
      }

      
      // if (challenges.publicChallenges != null &&
      //     challenges.publicChallenges!.isNotEmpty) {
      //   final publicIds = challenges.publicChallenges!.map((e) =>  e.id)
      //       .where((id) => id != null)
      //       .toList();
      //   box.write('id_public_challenges', publicIds);
      // }

      return challenges;
    }
    return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> generateChallenge() async {
    try {
      final token = box.read('access_token');
      final response = await _dio.post(
        'http://91.144.22.63:4567/boss/generate-challenge/',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}