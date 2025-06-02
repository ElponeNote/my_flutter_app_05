import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final VoidCallback onTap;
  final bool dark;
  const SearchBarWidget({super.key, required this.onTap, this.dark = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: dark ? const Color(0xFF23242A) : Colors.white,
      borderRadius: BorderRadius.circular(24),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Icon(Icons.search, color: dark ? Colors.grey[300] : Colors.grey[600]),
              const SizedBox(width: 12),
              Text(
                '검색',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: dark ? Colors.grey[300] : Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 