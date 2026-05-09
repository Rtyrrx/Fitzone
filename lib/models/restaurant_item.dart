import 'package:json_annotation/json_annotation.dart';

part 'restaurant_item.g.dart';

@JsonSerializable()
class MembershipPlan {
  final int? id;
  final int? centerId;
  final String name;
  final double price;
  final String description;
  final String duration;
  final String imageUrl;

  const MembershipPlan({
    this.id,
    this.centerId,
    required this.name,
    required this.price,
    required this.description,
    this.duration = 'Monthly',
    this.imageUrl = '',
  });

  factory MembershipPlan.fromJson(Map<String, dynamic> json) =>
      _$MembershipPlanFromJson(json);

  Map<String, dynamic> toJson() => _$MembershipPlanToJson(this);
}
