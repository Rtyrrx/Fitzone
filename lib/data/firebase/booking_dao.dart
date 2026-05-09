import 'package:cloud_firestore/cloud_firestore.dart' hide Order;

import '../../models/order.dart';
import '../../services/firebase_auth_service.dart';

class FirebaseBookingDao {
  FirebaseBookingDao(this._firestore, this._authService);

  final FirebaseFirestore _firestore;
  final FirebaseAuthService _authService;

  CollectionReference<Map<String, dynamic>> _bookingsForUser(String userId) {
    return _firestore.collection('users').doc(userId).collection('bookings');
  }

  Future<void> saveBooking(Order booking) async {
    final userId = _authService.currentUserId();
    if (userId == null) {
      throw Exception('Log in to save bookings.');
    }

    final userBooking = booking.copyWith(userId: userId);
    await _bookingsForUser(userId).doc(userBooking.id).set({
      ...userBooking.toJson(),
      ..._bookingSummary(userBooking),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteBooking(Order booking) async {
    final userId = _authService.currentUserId();
    if (userId == null) {
      throw Exception('Log in to delete bookings.');
    }

    await _bookingsForUser(userId).doc(booking.id).delete();
  }

  Stream<List<Order>> watchBookings() {
    final userId = _authService.currentUserId();
    if (userId == null) {
      return const Stream<List<Order>>.empty();
    }

    return _bookingsForUser(
      userId,
    ).orderBy('createdAt', descending: true).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = Map<String, dynamic>.from(doc.data());
        data['id'] = data['id'] ?? doc.id;
        data['userId'] = data['userId'] ?? userId;
        data['createdAt'] = _dateString(data['createdAt']);
        data['scheduledDate'] = _nullableDateString(data['scheduledDate']);
        return Order.fromJson(data);
      }).toList();
    });
  }

  String _dateString(Object? value) {
    if (value is Timestamp) {
      return value.toDate().toIso8601String();
    }
    if (value is DateTime) {
      return value.toIso8601String();
    }
    if (value is String && value.isNotEmpty) {
      return value;
    }
    return DateTime.now().toIso8601String();
  }

  String? _nullableDateString(Object? value) {
    if (value == null) {
      return null;
    }
    return _dateString(value);
  }

  Map<String, Object?> _bookingSummary(Order booking) {
    final itemSummaries = booking.items.map((cartItem) {
      final item = cartItem.item;
      return {
        'membershipId': item.id,
        'centerId': item.centerId,
        'name': item.name,
        'description': item.description,
        'duration': item.duration,
        'unitPrice': item.price,
        'quantity': cartItem.quantity,
        'lineTotal': cartItem.totalPrice,
      };
    }).toList();

    final itemNames = booking.items
        .map((cartItem) => '${cartItem.item.name} x${cartItem.quantity}')
        .join(', ');

    return {
      'userEmail': _authService.currentUserEmail() ?? '',
      'memberName': booking.memberName,
      'bookingType': booking.statusText,
      'bookingStatus': booking.status,
      'itemCount': booking.totalItems,
      'totalPrice': booking.totalPrice,
      'itemSummary': itemNames,
      'itemsReadable': itemSummaries,
      'createdAtReadable': booking.createdAt.toLocal().toString(),
      'scheduledDateReadable': booking.scheduledDate?.toLocal().toString(),
      'scheduledTimeReadable': booking.scheduledTime,
    };
  }
}
