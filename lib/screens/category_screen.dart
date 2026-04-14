import 'package:flutter/material.dart';
import '../widgets/category_card.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'name': 'Yoga',
        'icon': Icons.self_improvement,
        'color': Colors.purple,
        'itemCount': 15,
      },
      {
        'name': 'Gym',
        'icon': Icons.fitness_center,
        'color': Colors.orange,
        'itemCount': 28,
      },
      {
        'name': 'Cycling',
        'icon': Icons.directions_bike,
        'color': Colors.blue,
        'itemCount': 12,
      },
      {
        'name': 'Boxing',
        'icon': Icons.sports_mma,
        'color': Colors.red,
        'itemCount': 8,
      },
      {
        'name': 'Pool',
        'icon': Icons.pool,
        'color': Colors.cyan,
        'itemCount': 10,
      },
      {
        'name': 'CrossFit',
        'icon': Icons.sports_gymnastics,
        'color': Colors.green,
        'itemCount': 6,
      },
      {
        'name': 'Pilates',
        'icon': Icons.accessibility_new,
        'color': Colors.pink,
        'itemCount': 9,
      },
      {
        'name': 'Running',
        'icon': Icons.directions_run,
        'color': Colors.teal,
        'itemCount': 5,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryCard(
            name: category['name'] as String,
            icon: category['icon'] as IconData,
            color: category['color'] as Color,
            itemCount: category['itemCount'] as int,
          );
        },
      ),
    );
  }
}
