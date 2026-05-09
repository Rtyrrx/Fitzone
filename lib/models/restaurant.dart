import 'package:json_annotation/json_annotation.dart';

import 'restaurant_item.dart';

part 'restaurant.g.dart';

@JsonSerializable(explicitToJson: true)
class FitnessCenter {
  final int id;
  final String name;
  final String description;
  final String location;
  final String sportType;
  final double rating;
  final String openingHours;
  final String membershipPrice;
  final bool isOpen;
  final String imageUrl;
  final double distance;
  final List<MembershipPlan> memberships;

  const FitnessCenter({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.sportType,
    required this.rating,
    required this.openingHours,
    required this.membershipPrice,
    required this.isOpen,
    this.imageUrl = '',
    this.distance = 0.0,
    this.memberships = const [],
  });

  String get address => location;

  factory FitnessCenter.fromJson(Map<String, dynamic> json) =>
      _$FitnessCenterFromJson(json);

  Map<String, dynamic> toJson() => _$FitnessCenterToJson(this);
}
