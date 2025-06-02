import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsDetailPage extends StatelessWidget {
  final dynamic news;
  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    // 타입 분기: 더미 데이터는 imageUrl/summary, API 데이터는 urlToImage/description
    final isDummy = news.runtimeType.toString().contains('News') && news.imageUrl != null;
    final title = news.title;
    final summary = isDummy ? news.summary : news.description;
    final imageUrl = isDummy ? news.imageUrl : news.urlToImage;
    final source = news.source;
    final publishedAt = isDummy ? news.timeAgo : news.publishedAt;

    return Scaffold(
      appBar: AppBar(title: Text(source ?? '뉴스')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        children: [
          if (imageUrl != null && imageUrl.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.18 * 255).toInt()),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  imageUrl,
                  height: 240,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 240,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 36),
          Text(
            title,
            style: GoogleFonts.playfairDisplay(
              textStyle: Theme.of(context).textTheme.headlineSmall,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 24),
          Text(
            summary ?? '',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[800],
                  height: 1.7,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(source ?? '', style: TextStyle(color: Colors.grey[600], fontSize: 15)),
              Text(publishedAt ?? '', style: TextStyle(color: Colors.grey[500], fontSize: 15)),
            ],
          ),
        ],
      ),
    );
  }
} 