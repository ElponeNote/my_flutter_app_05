import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/dummy_data.dart';

class NewsCard extends StatelessWidget {
  final News news;
  final VoidCallback? onTap;
  const NewsCard({super.key, required this.news, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      elevation: 6,
      shadowColor: isDark ? Colors.black54 : Colors.black12,
      color: isDark ? const Color(0xFF23242A) : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 이미지 (상단만 라운드)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
              child: CachedNetworkImage(
                imageUrl: news.imageUrl,
                height: 190,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  height: 190,
                  color: isDark ? Colors.grey[800] : Colors.grey[200],
                ),
                errorWidget: (context, url, error) => Container(
                  height: 190,
                  color: isDark ? Colors.grey[900] : Colors.grey[300],
                  child: const Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 타이틀
                  Text(
                    news.title,
                    style: GoogleFonts.playfairDisplay(
                      textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 22,
                          ) ??
                          TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // 요약
                  Text(
                    news.summary,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDark ? Colors.grey[300] : Colors.grey[800],
                          height: 1.6,
                          fontSize: 15,
                        ) ??
                        TextStyle(
                          fontSize: 15,
                          color: isDark ? Colors.grey[300] : Colors.grey[800],
                        ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 