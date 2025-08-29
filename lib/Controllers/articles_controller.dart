import 'package:get/get.dart';
import 'package:homeworkout_flutter/Services/api_articles.dart';

class ArticlesController extends GetxController {
   final ApiArticles api = Get.find<ApiArticles>();
  var articles = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final String baseUrl = "http://workout.ofc.com.sy:4567";

  void loadArticles() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      var response = await api.fetchArticles();

      if (response.statusCode == 200) {
        var result = List<Map<String, dynamic>>.from(response.body);
        articles.value = result.map((article) {
          if (article['cover_image'] != null && article['cover_image'].isNotEmpty) {
            article['cover_image'] = "$baseUrl${article['cover_image']}";
          }
          return article;
        }).toList();
      } else {
        errorMessage.value = 'Failed to load articles';
      }
    } catch (e) {
      errorMessage.value = 'Failed to load articles';
    } finally {
      isLoading.value = false;
    }
  }
}