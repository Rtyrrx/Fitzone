import './restaurant_item.dart';

class FitnessCenter {
  final String name;
  final String sportType;
  final double rating;
  final String openingHours;
  final String membershipPrice;
  final bool isOpen;
  final String imageUrl;
  final String address;
  final double distance;
  final List<MembershipPlan> memberships;

  const FitnessCenter({
    required this.name,
    required this.sportType,
    required this.rating,
    required this.openingHours,
    required this.membershipPrice,
    required this.isOpen,
    this.imageUrl = '',
    this.address = '',
    this.distance = 0.0,
    this.memberships = const [],
  });
}
