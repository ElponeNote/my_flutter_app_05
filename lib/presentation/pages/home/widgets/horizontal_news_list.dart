import 'package:flutter/material.dart';
import '../../../../core/utils/dummy_data.dart';
import 'package:google_fonts/google_fonts.dart';
import '../news_detail_page.dart';

class HorizontalNewsList extends StatelessWidget {
  final String sectionTitle;
  final List<News> newsList;
  const HorizontalNewsList({super.key, required this.sectionTitle, required this.newsList});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 28, 8, 12),
          child: Row(
            children: [
              Container(
                width: 5,
                height: 24,
                decoration: BoxDecoration(
                  color: isDark ? Colors.blue[300] : Colors.blue[700],
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                sectionTitle,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: isDark ? Colors.white : Colors.black,
                    ) ??
                    TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: isDark ? Colors.white : Colors.black,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 240,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: newsList.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, idx) {
              final news = newsList[idx];
              return Container(
                width: 200,
                height: 215,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF23242A) : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black54 : Colors.black12,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NewsDetailPage(news: news),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                        child: Image.network(
                          news.imageUrl,
                          height: 95,
                          width: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 95,
                            color: isDark ? Colors.grey[900] : Colors.grey[300],
                            child: const Icon(Icons.error),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 6, 14, 2),
                        child: Text(
                          news.title,
                          style: GoogleFonts.playfairDisplay(
                            textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black,
                                  fontSize: 16,
                                ) ??
                                TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          news.summary,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: isDark ? Colors.grey[300] : Colors.grey[700],
                                height: 1.4,
                              ) ??
                              TextStyle(
                                fontSize: 13,
                                color: isDark ? Colors.grey[300] : Colors.grey[700],
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
                        child: Row(
                          children: [
                            Icon(Icons.thumb_up_alt, size: 16, color: Colors.blue[400]),
                            const SizedBox(width: 4),
                            Text(
                              'AI 추천',
                              style: TextStyle(
                                color: Colors.blue[400],
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(Icons.access_time, size: 14, color: Colors.grey[400]),
                            const SizedBox(width: 2),
                            Text(
                              news.timeAgo,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
} 