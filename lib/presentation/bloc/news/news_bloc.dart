import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_news_usecase.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsUseCase getNewsUseCase;

  NewsBloc({required this.getNewsUseCase}) : super(NewsInitial()) {
    on<LoadNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final newsList = await getNewsUseCase();
        emit(NewsLoaded(newsList));
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });

    on<SearchNews>((event, emit) {
      // SearchNews 이벤트는 필요에 따라 구현
    });
  }
} 