import 'package:app_news/models/ArticleModel.dart';
import 'package:app_news/models/news_item.dart';
import 'package:dio/dio.dart';

class NewsService {
  final Dio dio;

  NewsService(this.dio);
  Future<List<ArticleModel>> getNews() async {
    try {
      Response response = await dio.get(
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=87d13b370e3144bb9ddefc1af56fb94e',
      );
      Map<String, dynamic> jsonData = response.data;
      List<dynamic> articles = jsonData['articles'];
      List<ArticleModel> articlesList = [];
      for (var article in articles) {
        ArticleModel articleModel = ArticleModel(
          url: article['url']?? '',
          content: article['content'] ?? '',
          description: article['description'] ?? '',
          sharedAt: article['publishedAt'] ?? '',
          title: article['title'] ?? '',
          imgUrl: article['urlToImage'] ?? '',
          author: article['author'] ?? '',
        );
        articlesList.add(articleModel);
      }
      return articlesList;
    }   catch (e) {
      return [];
    }
  }
}
