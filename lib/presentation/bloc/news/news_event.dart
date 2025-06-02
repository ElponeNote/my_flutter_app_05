abstract class NewsEvent {}

class LoadNews extends NewsEvent {}

class SearchNews extends NewsEvent {
  final String keyword;
  SearchNews(this.keyword);
} 