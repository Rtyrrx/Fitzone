import 'package:flutter/material.dart';
import '../widgets/restaurant_card.dart';

class FitnessCenterScreen extends StatelessWidget {
  const FitnessCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fitnessCenters = [
      {
        'name': 'Iron Paradise Gym',
        'sportType': 'Gym',
        'rating': 4.8,
        'openingHours': '5AM - 11PM',
        'membershipPrice': '\$29.99/mo',
        'isOpen': true,
      },
      {
        'name': 'Zen Yoga Studio',
        'sportType': 'Yoga',
        'rating': 4.9,
        'openingHours': '6AM - 9PM',
        'membershipPrice': '\$89.99/mo',
        'isOpen': true,
      },
      {
        'name': 'SpinCycle Studio',
        'sportType': 'Cycling',
        'rating': 4.7,
        'openingHours': '5:30AM - 8PM',
        'membershipPrice': '\$149.99/mo',
        'isOpen': true,
      },
      {
        'name': 'Champions Boxing Club',
        'sportType': 'Boxing',
        'rating': 4.6,
        'openingHours': '6AM - 10PM',
        'membershipPrice': '\$79.99/mo',
        'isOpen': false,
      },
      {
        'name': 'Aqua Life Center',
        'sportType': 'Pool',
        'rating': 4.5,
        'openingHours': '6AM - 9PM',
        'membershipPrice': '\$45.99/mo',
        'isOpen': true,
      },
      {
        'name': 'CrossFit Revolution',
        'sportType': 'CrossFit',
        'rating': 4.8,
        'openingHours': '5AM - 9PM',
        'membershipPrice': '\$175/mo',
        'isOpen': true,
      },
      {
        'name': 'Flex Fitness Club',
        'sportType': 'Gym',
        'rating': 4.4,
        'openingHours': '24/7',
        'membershipPrice': '\$19.99/mo',
        'isOpen': true,
      },
      {
        'name': 'Pure Pilates',
        'sportType': 'Pilates',
        'rating': 4.7,
        'openingHours': '7AM - 8PM',
        'membershipPrice': '\$99/mo',
        'isOpen': false,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: fitnessCenters.length,
      itemBuilder: (context, index) {
        final center = fitnessCenters[index];
        return FitnessCenterCard(
          name: center['name'] as String,
          sportType: center['sportType'] as String,
          rating: center['rating'] as double,
          openingHours: center['openingHours'] as String,
          membershipPrice: center['membershipPrice'] as String,
          isOpen: center['isOpen'] as bool,
        );
      },
    );
  }
}
