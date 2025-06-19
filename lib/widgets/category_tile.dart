import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const CategoryTile({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
