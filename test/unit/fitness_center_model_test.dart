import 'package:chapter3/models/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FitnessCenter JSON serialization', () {
    final json = <String, dynamic>{
      'id': 7,
      'name': 'Elite Strength Club',
      'description': 'Full-service strength and conditioning center',
      'location': '77 Power Avenue',
      'sportType': 'Gym',
      'rating': 4.7,
      'openingHours': '5AM - 11PM',
      'membershipPrice': '\$69.99/mo',
      'isOpen': true,
      'imageUrl': '',
      'distance': 2.4,
      'memberships': [
        {
          'id': 12,
          'centerId': 7,
          'name': 'Standard',
          'price': 69.99,
          'description': 'Monthly membership',
          'duration': 'Monthly',
          'imageUrl': '',
        },
      ],
    };

    test('fromJson parses a fitness center', () {
      final center = FitnessCenter.fromJson(json);

      expect(center.id, 7);
      expect(center.name, 'Elite Strength Club');
      expect(center.location, '77 Power Avenue');
      expect(center.sportType, 'Gym');
      expect(center.rating, 4.7);
      expect(center.memberships, hasLength(1));
      expect(center.memberships.first.name, 'Standard');
    });

    test('toJson exports the expected values', () {
      final center = FitnessCenter.fromJson(json);
      final encoded = center.toJson();

      expect(encoded['id'], 7);
      expect(encoded['name'], 'Elite Strength Club');
      expect(encoded['location'], '77 Power Avenue');
      expect(encoded['sportType'], 'Gym');
      expect(encoded['rating'], 4.7);
      expect((encoded['memberships'] as List).single['name'], 'Standard');
    });
  });
}
