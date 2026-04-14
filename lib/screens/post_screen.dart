import 'package:flutter/material.dart';
import '../widgets/post_card.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = [
      {
        'title': 'Best Gyms in Town',
        'description':
            'Discover the top 10 fitness centers that have the best equipment, trainers, and atmosphere for your workout goals.',
        'author': 'John Smith',
        'date': 'March 25, 2026',
        'icon': Icons.fitness_center,
      },
      {
        'title': 'Beginner Yoga Tips',
        'description':
            'Learn how to start your yoga journey with these essential tips from certified yoga instructors. Perfect for beginners!',
        'author': 'Sarah Johnson',
        'date': 'March 24, 2026',
        'icon': Icons.self_improvement,
      },
      {
        'title': 'Indoor Cycling Guide',
        'description':
            'From spin bikes to proper form, explore everything you need to know about indoor cycling and its amazing benefits.',
        'author': 'Mike Brown',
        'date': 'March 23, 2026',
        'icon': Icons.directions_bike,
      },
      {
        'title': 'Boxing for Fitness',
        'description':
            'Step by step guide to getting started with boxing workouts. Build strength, cardio, and confidence in one session.',
        'author': 'Emily Chen',
        'date': 'March 22, 2026',
        'icon': Icons.sports_mma,
      },
      {
        'title': 'Swimming Workout Ideas',
        'description':
            'Dive into these refreshing pool workout routines perfect for all fitness levels. Low impact, high results!',
        'author': 'Lisa White',
        'date': 'March 21, 2026',
        'icon': Icons.pool,
      },
      {
        'title': 'Fitness Photography Tips',
        'description':
            'Capture your fitness journey with these simple techniques for gym selfies and progress photos.',
        'author': 'David Lee',
        'date': 'March 20, 2026',
        'icon': Icons.photo_camera,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostCard(
          title: post['title'] as String,
          description: post['description'] as String,
          author: post['author'] as String,
          date: post['date'] as String,
          icon: post['icon'] as IconData,
        );
      },
    );
  }
}
