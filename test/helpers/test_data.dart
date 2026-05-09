import 'package:chapter3/models/cart_item.dart';
import 'package:chapter3/models/order.dart';
import 'package:chapter3/models/restaurant.dart';
import 'package:chapter3/models/restaurant_item.dart';

class TestUser {
  final String id;
  final String email;

  const TestUser({required this.id, required this.email});
}

const fakeUser = TestUser(id: 'test-user-1', email: 'student@fitzone.test');

const fakeMembership = MembershipPlan(
  id: 101,
  centerId: 1,
  name: 'Monthly Pro',
  price: 49.99,
  description: 'Unlimited access and one personal training session.',
  duration: 'Monthly',
  imageUrl: '',
);

const fakeSecondMembership = MembershipPlan(
  id: 102,
  centerId: 1,
  name: 'Day Pass',
  price: 15.00,
  description: 'One-day access to the gym floor.',
  duration: 'Day',
  imageUrl: '',
);

FitnessCenter buildFakeFitnessCenter({List<MembershipPlan>? memberships}) {
  return FitnessCenter(
    id: 1,
    name: 'FitZone Test Hub',
    description: 'A deterministic fitness center used in automated tests.',
    location: '123 Test Street',
    sportType: 'Gym',
    rating: 4.9,
    openingHours: '6AM - 10PM',
    membershipPrice: '\$49.99/mo',
    isOpen: true,
    imageUrl: '',
    distance: 1.5,
    memberships: memberships ?? const [fakeMembership, fakeSecondMembership],
  );
}

CartItem buildFakeBookingItem({
  String id = 'cart-1',
  MembershipPlan membership = fakeMembership,
  int quantity = 1,
}) {
  return CartItem(id: id, item: membership, quantity: quantity);
}

Order buildFakeBooking({
  String id = 'booking-1',
  String userId = 'test-user-1',
  List<CartItem>? items,
  BookingType type = BookingType.inPerson,
  String memberName = 'Test Member',
  DateTime? scheduledDate,
  String? scheduledTime,
  DateTime? createdAt,
}) {
  return Order(
    id: id,
    userId: userId,
    items: items ?? [buildFakeBookingItem()],
    type: type,
    memberName: memberName,
    scheduledDate: scheduledDate,
    scheduledTime: scheduledTime,
    createdAt: createdAt ?? DateTime(2026, 5, 17, 10),
  );
}
