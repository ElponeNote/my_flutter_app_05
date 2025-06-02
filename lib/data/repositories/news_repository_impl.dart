import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news.dart';

class NewsRepositoryImpl {
  static const String _apiKey = '25b2104bc39045cbb7f54e5bfd5bb714';
  static const String _baseUrl = 'https://newsapi.org/v2/top-headlines?country=kr&apiKey=$_apiKey';

  Future<List<News>> fetchNews() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List articles = data['articles'];
      return articles.map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('뉴스를 불러오지 못했습니다');
    }
  }
} 