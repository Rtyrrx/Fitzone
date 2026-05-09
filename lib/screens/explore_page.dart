import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/explore_data.dart';
import '../models/restaurant.dart';
import '../services/mock_yummy_service.dart';
import '../services/user_preferences_manager.dart';
import '../components/category_section.dart';
import '../components/post_section.dart';
import '../components/restaurant_section.dart';

class ExplorePage extends StatefulWidget {
  final int currentTab;
  final List<FitnessCenter> fitnessCenters;
  final UserPreferencesManager preferencesManager;

  const ExplorePage({
    super.key,
    required this.currentTab,
    required this.fitnessCenters,
    required this.preferencesManager,
  });

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final MockFitnessService _mockService = MockFitnessService();
  late Future<ExploreData> _exploreDataFuture;
  String? _selectedSportType;

  @override
  void initState() {
    super.initState();
    _exploreDataFuture = _mockService.getExploreData();
  }

  void _handleSportTypeChanged(String? sportType) {
    setState(() {
      _selectedSportType = sportType;
    });
  }

  Future<void> _showJsonPreview() async {
    final jsonText = await rootBundle.loadString('assets/json/fitness_centers.json');
    if (!mounted) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Fitness Centers JSON'),
          content: SizedBox(
            width: 600,
            child: SingleChildScrollView(
              child: SelectableText(
                jsonText,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'Courier',
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ExploreData>(
      future: _exploreDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final data = snapshot.data!;

        return ListView(
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton.icon(
                  onPressed: _showJsonPreview,
                  icon: const Icon(Icons.data_object),
                  label: const Text('View JSON'),
                ),
              ),
            ),
            const SizedBox(height: 8),
            FitnessCenterSection(
              fitnessCenters: widget.fitnessCenters,
              currentTab: widget.currentTab,
              preferencesManager: widget.preferencesManager,
              selectedSportType: _selectedSportType,
              onSportTypeChanged: _handleSportTypeChanged,
            ),
            const SizedBox(height: 16),
            CategorySection(
              categories: data.categories,
              selectedCategory: _selectedSportType,
              onCategorySelected: _handleSportTypeChanged,
            ),
            const SizedBox(height: 16),
            PostSection(posts: data.friendPosts),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
