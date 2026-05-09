import 'package:chapter3/models/order.dart';
import 'package:chapter3/services/cart_manager.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_data.dart';

void main() {
  group('CartManager booking logic', () {
    test('starts with an empty booking state', () {
      final manager = CartManager();

      expect(manager.items, isEmpty);
      expect(manager.itemCount, 0);
      expect(manager.totalPrice, 0);
    });

    test('adds a booking item', () {
      final manager = CartManager();
      final item = buildFakeBookingItem();

      manager.addItem(item);

      expect(manager.items, hasLength(1));
      expect(manager.itemCount, 1);
      expect(manager.items.first.item.name, fakeMembership.name);
    });

    test('calculates total price from booking items', () {
      final manager = CartManager();

      manager.addItem(buildFakeBookingItem(quantity: 2));
      manager.addItem(
        buildFakeBookingItem(
          id: 'cart-2',
          membership: fakeSecondMembership,
          quantity: 1,
        ),
      );

      expect(manager.totalPrice, closeTo(114.98, 0.001));
      expect(manager.itemCount, 3);
    });

    test('removes a booking item', () {
      final manager = CartManager();
      final firstItem = buildFakeBookingItem(id: 'first');
      final secondItem = buildFakeBookingItem(id: 'second');

      manager.addItem(firstItem);
      manager.addItem(secondItem);
      manager.removeItem('first');

      expect(manager.items, hasLength(1));
      expect(manager.items.single.id, 'second');
    });

    test('creates a booking from selected items', () {
      final booking = buildFakeBooking(
        type: BookingType.scheduled,
        items: [buildFakeBookingItem(quantity: 2)],
        memberName: 'Alex',
        scheduledDate: DateTime(2026, 5, 18),
        scheduledTime: '9:00 AM',
      );

      expect(booking.memberName, 'Alex');
      expect(booking.type, BookingType.scheduled);
      expect(booking.totalItems, 2);
      expect(booking.totalPrice, closeTo(99.98, 0.001));
      expect(booking.scheduledTime, '9:00 AM');
    });
  });
}
