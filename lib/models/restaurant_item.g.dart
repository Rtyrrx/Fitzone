// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MembershipPlan _$MembershipPlanFromJson(Map<String, dynamic> json) =>
    MembershipPlan(
      id: (json['id'] as num?)?.toInt(),
      centerId: (json['centerId'] as num?)?.toInt(),
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      duration: json['duration'] as String? ?? 'Monthly',
      imageUrl: json['imageUrl'] as String? ?? '',
    );

Map<String, dynamic> _$MembershipPlanToJson(MembershipPlan instance) =>
    <String, dynamic>{
      'id': instance.id,
      'centerId': instance.centerId,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'duration': instance.duration,
      'imageUrl': instance.imageUrl,
    };
