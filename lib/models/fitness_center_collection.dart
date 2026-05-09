import 'package:json_annotation/json_annotation.dart';

import 'restaurant.dart';

part 'fitness_center_collection.g.dart';

@JsonSerializable(explicitToJson: true)
class FitnessCenterCollection {
  final List<FitnessCenter> centers;

  const FitnessCenterCollection({required this.centers});

  factory FitnessCenterCollection.fromJson(Map<String, dynamic> json) =>
      _$FitnessCenterCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$FitnessCenterCollectionToJson(this);
}
