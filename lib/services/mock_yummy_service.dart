import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/explore_data.dart';
import '../models/fitness_center_collection.dart';
import '../models/food_category.dart';
import '../models/post.dart';
import '../models/restaurant.dart';

class MockFitnessService {
  static const _categoryVisuals = {
    'Gym': (
      icon: Icons.fitness_center,
      color: Colors.orange,
      imageUrl:
          'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=200&h=200&fit=crop',
    ),
    'Yoga': (
      icon: Icons.self_improvement,
      color: Colors.purple,
      imageUrl:
          'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=200&h=200&fit=crop',
    ),
    'Cycling': (
      icon: Icons.directions_bike,
      color: Colors.blue,
      imageUrl:
          'https://images.unsplash.com/photo-1517649763962-0c623066013b?w=200&h=200&fit=crop',
    ),
    'Boxing': (
      icon: Icons.sports_mma,
      color: Colors.red,
      imageUrl:
          'https://images.unsplash.com/photo-1549719386-74dfcbf7dbed?w=200&h=200&fit=crop',
    ),
    'Pool': (
      icon: Icons.pool,
      color: Colors.cyan,
      imageUrl:
          'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?w=200&h=200&fit=crop',
    ),
    'CrossFit': (
      icon: Icons.sports_gymnastics,
      color: Colors.green,
      imageUrl:
          'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?w=200&h=200&fit=crop',
    ),
  };

  Future<ExploreData> getExploreData() async {
    final fitnessCenters = await _loadFitnessCenters();
    return ExploreData(
      fitnessCenters: fitnessCenters,
      categories: _buildCategories(fitnessCenters),
      friendPosts: const [
        Post(
          title: 'Amazing Yoga Session!',
          description:
              'Just finished an incredible hot yoga class at Zen Yoga Studio. The instructor was so attentive and the atmosphere was perfect for relaxation!',
          author: 'Sarah M.',
          date: 'Today',
          icon: Icons.self_improvement,
          avatarUrl: 'images/e3dcd545b8b34d404217b5da7bcf9775.jpg',
        ),
        Post(
          title: 'New PR at the Gym!',
          description:
              'Hit a new personal record on deadlift at Iron Paradise! The equipment is top-notch and the trainers really push you to do your best.',
          author: 'Mike R.',
          date: 'Yesterday',
          icon: Icons.fitness_center,
          avatarUrl: 'images/a8898449b7db9a021a187a5006e2ee43.jpg',
        ),
        Post(
          title: 'First Boxing Class Done!',
          description:
              'Finally tried boxing at Uppercut Arena. What a workout! My arms are sore but I feel amazing.',
          author: 'Emma L.',
          date: '2 days ago',
          icon: Icons.sports_mma,
          avatarUrl: 'images/028b5f12160c4a23a9c3b6ec8e2375dc.jpg',
        ),
        Post(
          title: 'Morning Swim Routine',
          description:
              'Started my day with laps at Blue Wave Aquatics. The pool is so clean and the early morning crowd is super friendly.',
          author: 'David K.',
          date: '3 days ago',
          icon: Icons.pool,
          avatarUrl: 'images/8b696d542e16dca8853562c352d55438.jpg',
        ),
        Post(
          title: 'Best Spin Playlist Ever',
          description:
              'Velo Pulse Studio had a playlist that made the whole ride fly by. Intense intervals and such a motivating coach.',
          author: 'Leila S.',
          date: '4 days ago',
          icon: Icons.directions_bike,
          avatarUrl: 'images/6552f06370a60a3bafe50d15f66d6587.jpg',
        ),
        Post(
          title: 'CrossFit Team WOD',
          description:
              'Forge Functional Club had an incredible partner workout tonight. Tough session, but the team atmosphere made it fun.',
          author: 'Timur B.',
          date: '6 days ago',
          icon: Icons.sports_gymnastics,
          avatarUrl: 'images/c5b60e16a7ab446993298ffcf9cf5418.jpg',
        ),
      ],
    );
  }

  Future<List<FitnessCenter>> _loadFitnessCenters() async {
    final response = await rootBundle.loadString(
      'assets/json/fitness_centers.json',
    );
    final decoded = jsonDecode(response) as Map<String, dynamic>;
    return FitnessCenterCollection.fromJson(decoded).centers;
  }

  List<SportCategory> _buildCategories(List<FitnessCenter> fitnessCenters) {
    final counts = <String, int>{};
    for (final center in fitnessCenters) {
      counts.update(center.sportType, (count) => count + 1, ifAbsent: () => 1);
    }

    return _categoryVisuals.entries.map((entry) {
      final visuals = entry.value;
      return SportCategory(
        name: entry.key,
        icon: visuals.icon,
        color: visuals.color,
        centerCount: counts[entry.key] ?? 0,
        imageUrl: visuals.imageUrl,
      );
    }).toList();
  }
}
