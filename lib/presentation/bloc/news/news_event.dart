abstract class NewsEvent {}

class LoadNews extends NewsEvent {}

class SearchNews extends NewsEvent {
  final String query;
  SearchNews(this.query);
} 