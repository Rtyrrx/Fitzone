import 'package:drift/drift.dart';

import '../../models/cart_item.dart';
import '../../models/order.dart';
import '../../models/restaurant.dart';
import '../../models/restaurant_item.dart';
import 'app_database.dart';

extension FitnessCenterDatabaseMapper on FitnessCenter {
  DbFitnessCentersCompanion toCenterCompanion() {
    return DbFitnessCentersCompanion(
      id: Value(id),
      name: Value(name),
      location: Value(location),
      description: Value(description),
      imageUrl: Value(imageUrl),
      sportType: Value(sportType),
      rating: Value(rating),
      openingHours: Value(openingHours),
      membershipPrice: Value(membershipPrice),
      isOpen: Value(isOpen),
      distance: Value(distance),
    );
  }
}

extension DbFitnessCenterMapper on DbFitnessCenter {
  FitnessCenter toModel(List<MembershipPlan> memberships) {
    return FitnessCenter(
      id: id,
      name: name,
      description: description,
      location: location,
      sportType: sportType,
      rating: rating,
      openingHours: openingHours,
      membershipPrice: membershipPrice,
      isOpen: isOpen,
      imageUrl: imageUrl,
      distance: distance,
      memberships: memberships,
    );
  }
}

extension MembershipDatabaseMapper on MembershipPlan {
  DbMembershipsCompanion toMembershipCompanion({required int centerId}) {
    return DbMembershipsCompanion(
      id: id == null ? const Value.absent() : Value(id!),
      centerId: Value(centerId),
      name: Value(name),
      price: Value(price),
      description: Value(description),
      duration: Value(duration),
      imageUrl: Value(imageUrl),
    );
  }
}

extension DbMembershipMapper on DbMembership {
  MembershipPlan toModel() {
    return MembershipPlan(
      id: id,
      centerId: centerId,
      name: name,
      price: price,
      description: description,
      duration: duration,
      imageUrl: imageUrl,
    );
  }
}

extension BookingDatabaseMapper on Order {
  DbBookingsCompanion toBookingCompanion() {
    return DbBookingsCompanion(
      userId: Value(userId),
      contactName: Value(memberName),
      selectedDate: Value(scheduledDate),
      selectedTime: Value(scheduledTime),
      status: Value(status),
      totalCost: Value(totalPrice),
      createdAt: Value(createdAt),
    );
  }
}

extension DbBookingMapper on DbBooking {
  Order toModel(List<CartItem> items) {
    return Order(
      databaseId: id,
      id: id.toString(),
      userId: userId,
      items: items,
      type: selectedDate == null ? BookingType.inPerson : BookingType.scheduled,
      memberName: contactName,
      scheduledDate: selectedDate,
      scheduledTime: selectedTime,
      status: status,
      createdAt: createdAt,
    );
  }
}

extension BookingItemDatabaseMapper on CartItem {
  DbBookingItemsCompanion toBookingItemCompanion({
    required int bookingId,
  }) {
    return DbBookingItemsCompanion(
      bookingId: Value(bookingId),
      membershipId: Value(item.id ?? 0),
      quantity: Value(quantity),
      price: Value(item.price),
    );
  }
}

extension DbBookingItemMapper on DbBookingItem {
  CartItem toModel(MembershipPlan membership) {
    return CartItem(
      id: id.toString(),
      item: membership,
      quantity: quantity,
    );
  }
}
