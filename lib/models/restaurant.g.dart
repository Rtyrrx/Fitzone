// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FitnessCenter _$FitnessCenterFromJson(Map<String, dynamic> json) =>
    FitnessCenter(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      sportType: json['sportType'] as String,
      rating: (json['rating'] as num).toDouble(),
      openingHours: json['openingHours'] as String,
      membershipPrice: json['membershipPrice'] as String,
      isOpen: json['isOpen'] as bool,
      imageUrl: json['imageUrl'] as String? ?? '',
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      memberships:
          (json['memberships'] as List<dynamic>?)
              ?.map((e) => MembershipPlan.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FitnessCenterToJson(FitnessCenter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'sportType': instance.sportType,
      'rating': instance.rating,
      'openingHours': instance.openingHours,
      'membershipPrice': instance.membershipPrice,
      'isOpen': instance.isOpen,
      'imageUrl': instance.imageUrl,
      'distance': instance.distance,
      'memberships': instance.memberships.map((e) => e.toJson()).toList(),
    };
