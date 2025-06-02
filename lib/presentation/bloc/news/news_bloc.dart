import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/dummy_data.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<LoadNews>((event, emit) async {
      emit(NewsLoading());
      await Future.delayed(const Duration(milliseconds: 300));
      emit(NewsLoaded(dummyNewsList));
    });

    on<SearchNews>((event, emit) {
      final filtered = dummyNewsList
          .where((news) =>
              news.title.contains(event.keyword) ||
              news.summary.contains(event.keyword))
          .toList();
      emit(NewsLoaded(filtered));
    });
  }
} 