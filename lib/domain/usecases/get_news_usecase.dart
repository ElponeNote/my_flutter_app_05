import '../../data/models/news.dart';
import '../../data/repositories/news_repository_impl.dart';

class GetNewsUseCase {
  final NewsRepositoryImpl _repository;
  GetNewsUseCase({NewsRepositoryImpl? repository}) : _repository = repository ?? NewsRepositoryImpl();

  Future<List<News>> call() async {
    return await _repository.fetchNews();
  }
} 