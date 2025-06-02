import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 28, 8, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Apple News 스타일의 컬러 인디케이터
          Container(
            width: 5,
            height: 28,
            decoration: BoxDecoration(
              color: isDark ? Colors.blue[300] : Colors.blue[700],
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  color: isDark ? Colors.white : Colors.black,
                  letterSpacing: -0.5,
                ) ??
                TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                  color: isDark ? Colors.white : Colors.black,
                  letterSpacing: -0.5,
                ),
          ),
        ],
      ),
    );
  }
} 