import 'package:flutter/material.dart';
import '../../../../core/utils/dummy_data.dart';
import 'news_card.dart';
import 'section_header.dart';

class NewsSection extends StatelessWidget {
  final String sectionTitle;
  final List<News> newsList;
  const NewsSection({super.key, required this.sectionTitle, required this.newsList});

  @override
  Widget build(BuildContext context) {
    if (newsList.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: sectionTitle),
        ...newsList.map((news) => NewsCard(news: news)),
      ],
    );
  }
} 