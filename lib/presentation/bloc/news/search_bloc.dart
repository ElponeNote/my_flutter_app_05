import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/dummy_data.dart'; // News, dummyNewsList

// --- Events ---
abstract class SearchEvent {}
class SearchQueryChanged extends SearchEvent {
  final String query;
  SearchQueryChanged(this.query);
}
class SearchCleared extends SearchEvent {}

// --- States ---
abstract class SearchState {}
class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}
class SearchLoaded extends SearchState {
  final List<News> results;
  SearchLoaded(this.results);
}
class SearchEmpty extends SearchState {}
class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}

// --- Bloc ---
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final List<News> allNews;
  SearchBloc(this.allNews) : super(SearchInitial()) {
    on<SearchQueryChanged>((event, emit) async {
      emit(SearchLoading());
      await Future.delayed(const Duration(milliseconds: 200)); // debounce 효과
      final query = event.query.trim().toLowerCase();
      if (query.isEmpty) {
        emit(SearchInitial());
        return;
      }
      final results = allNews.where((news) =>
        news.title.toLowerCase().contains(query) ||
        news.summary.toLowerCase().contains(query) ||
        news.category.name.toLowerCase().contains(query) ||
        news.source.toLowerCase().contains(query)
      ).toList();
      if (results.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchLoaded(results));
      }
    });
    on<SearchCleared>((event, emit) => emit(SearchInitial()));
  }
} 