// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fitness_center_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FitnessCenterCollection _$FitnessCenterCollectionFromJson(
  Map<String, dynamic> json,
) => FitnessCenterCollection(
  centers: (json['centers'] as List<dynamic>)
      .map((e) => FitnessCenter.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$FitnessCenterCollectionToJson(
  FitnessCenterCollection instance,
) => <String, dynamic>{
  'centers': instance.centers.map((e) => e.toJson()).toList(),
};
