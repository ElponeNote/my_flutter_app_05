import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/dummy_data.dart' as dummy;
import '../../../data/models/news.dart' as model;

class NewsDetailPage extends StatelessWidget {
  final dynamic news;
  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    // Determine if this is dummy.News or model.News
    final isDummy = news is dummy.News;
    final title = isDummy ? news.title : news.title;
    final summary = isDummy ? news.summary : news.description;
    final imageUrl = isDummy ? news.imageUrl : news.urlToImage;
    final source = isDummy ? news.source : news.source;
    final timeAgo = isDummy ? news.timeAgo : news.publishedAt;
    return Scaffold(
      backgroundColor: const Color(0xFF101014),
      appBar: AppBar(
        backgroundColor: const Color(0xFF101014),
        elevation: 0.5,
        title: Text(
          '뉴스',
          style: GoogleFonts.playfairDisplay(
            textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ) ?? const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        children: [
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
                  color: Colors.grey[900],
                  child: const Icon(Icons.error, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 36),
          Text(
            title,
            style: GoogleFonts.playfairDisplay(
              textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ) ?? const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 24),
          Text(
            summary,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[300],
                  height: 1.7,
                  fontSize: 18,
                ) ?? const TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue[700]?.withAlpha(180),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  source,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ) ?? const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                timeAgo,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 