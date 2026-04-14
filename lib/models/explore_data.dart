import 'restaurant.dart';
import 'food_category.dart';
import 'post.dart';

class ExploreData {
  final List<FitnessCenter> fitnessCenters;
  final List<SportCategory> categories;
  final List<Post> friendPosts;

  const ExploreData({
    required this.fitnessCenters,
    required this.categories,
    required this.friendPosts,
  });
}
