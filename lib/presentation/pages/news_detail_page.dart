import 'package:flutter/material.dart';
import '../../data/models/news.dart';

class NewsDetailPage extends StatelessWidget {
  final News news;
  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(news.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.urlToImage.isNotEmpty)
              Image.network(news.urlToImage, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(news.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(news.publishedAt, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            Text(news.description),
            const SizedBox(height: 16),
            Text('출처: ${news.source}', style: const TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }
} 