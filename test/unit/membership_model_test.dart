import 'package:chapter3/models/restaurant_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MembershipPlan JSON serialization', () {
    final json = <String, dynamic>{
      'id': 21,
      'centerId': 3,
      'name': 'Premium Pass',
      'price': 89.99,
      'description': 'Unlimited sessions and classes',
      'duration': 'Monthly',
      'imageUrl': '',
    };

    test('fromJson parses a membership', () {
      final membership = MembershipPlan.fromJson(json);

      expect(membership.id, 21);
      expect(membership.centerId, 3);
      expect(membership.name, 'Premium Pass');
      expect(membership.price, 89.99);
      expect(membership.duration, 'Monthly');
    });

    test('toJson exports the expected values', () {
      final membership = MembershipPlan.fromJson(json);
      final encoded = membership.toJson();

      expect(encoded['id'], 21);
      expect(encoded['centerId'], 3);
      expect(encoded['name'], 'Premium Pass');
      expect(encoded['price'], 89.99);
      expect(encoded['description'], 'Unlimited sessions and classes');
    });
  });
}
