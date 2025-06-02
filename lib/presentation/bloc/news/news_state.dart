import '../../../data/models/news.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<News> newsList;
  NewsLoaded(this.newsList);
}

class NewsSearchResult extends NewsState {
  final List<News> searchResults;
  NewsSearchResult(this.searchResults);
}

class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
} 