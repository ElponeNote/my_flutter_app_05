import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_news_usecase.dart';
import '../../../data/models/news.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase getNewsUseCase;
  List<News> _allNews = [];

  NewsBloc({required this.getNewsUseCase}) : super(NewsInitial()) {
    on<LoadNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final newsList = await getNewsUseCase();
        _allNews = newsList;
        emit(NewsLoaded(newsList));
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });

    on<SearchNews>((event, emit) {
      final query = event.query.trim().toLowerCase();
      if (query.isEmpty) {
        emit(NewsLoaded(_allNews));
      } else {
        final results = _allNews.where((news) =>
          news.title.toLowerCase().contains(query) ||
          news.description.toLowerCase().contains(query)
        ).toList();
        emit(NewsSearchResult(results));
      }
    });
  }
}