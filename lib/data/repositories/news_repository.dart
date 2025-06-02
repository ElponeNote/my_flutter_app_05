import '../../core/utils/dummy_data.dart';

class NewsRepository {
  // 모든 뉴스 반환
  List<News> getAllNews() => dummyNewsList;

  // AI 추천 뉴스 반환
  List<News> getAINews() => aiRecommendedNewsList;

  // 검색 기능 (제목, 요약, 카테고리명)
  List<News> searchNews(String query) {
    final lowerQuery = query.trim().toLowerCase();
    return dummyNewsList.where((news) {
      return news.title.toLowerCase().contains(lowerQuery) ||
          news.summary.toLowerCase().contains(lowerQuery) ||
          news.category.name.toLowerCase().contains(lowerQuery);
    }).toList();
  }
} 