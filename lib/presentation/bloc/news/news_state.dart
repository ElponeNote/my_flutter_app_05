import '../../../core/utils/dummy_data.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<News> newsList;
  NewsLoaded(this.newsList);
}

class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
} 