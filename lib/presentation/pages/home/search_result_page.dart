import 'package:flutter/material.dart';
import '../../../data/repositories/news_repository.dart';
import 'widgets/news_card.dart';

class SearchResultPage extends StatelessWidget {
  final String query;
  const SearchResultPage({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsRepository = NewsRepository();
    final results = newsRepository.searchNews(query);

    return Scaffold(
      appBar: AppBar(
        title: Text('"$query" 검색 결과'),
      ),
      body: results.isEmpty
          ? const Center(child: Text('검색 결과가 없습니다.'))
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final news = results[index];
                return NewsCard(
                  news: news,
                  onTap: () {
                    // 상세 페이지로 이동 (기존 NewsCard onTap과 동일하게 구현)
                  },
                );
              },
            ),
    );
  }
} 