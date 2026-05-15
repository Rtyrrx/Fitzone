import 'package:cloud_firestore/cloud_firestore.dart' hide Order;

import '../../models/booking_history_entry.dart';
import '../../models/order.dart';
import '../../services/firebase_auth_service.dart';

class FirebaseBookingDao {
  FirebaseBookingDao(this._firestore, this._authService);

  final FirebaseFirestore _firestore;
  final FirebaseAuthService _authService;

  CollectionReference<Map<String, dynamic>> _bookingsForUser(String userId) {
    return _firestore.collection('users').doc(userId).collection('bookings');
  }

  CollectionReference<Map<String, dynamic>> _historyForUser(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('booking_history');
  }

  CollectionReference<Map<String, dynamic>> _globalHistory() {
    return _firestore.collection('booking_history');
  }

  CollectionReference<Map<String, dynamic>> _readableHistory() {
    return _firestore.collection('booking_history_readable');
  }

  Future<void> saveBooking(Order booking) async {
    final userId = _authService.currentUserId();
    if (userId == null) {
      throw Exception('Log in to save bookings.');
    }

    final userBooking = booking.copyWith(userId: userId);
    final bookingCode = _bookingCode(userBooking);
    final bookingPayload = {
      ...userBooking.toJson(),
      ..._bookingSummary(userBooking),
      'bookingCode': bookingCode,
      'userLabel': _userLabel(userId),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    final historyPayload = _historyPayload(
      userBooking,
      eventType: 'created',
      bookingCode: bookingCode,
      userId: userId,
    );

    final batch = _firestore.batch();
    batch.set(_bookingsForUser(userId).doc(userBooking.id), bookingPayload);
    batch.set(
      _historyForUser(userId).doc('created_$bookingCode'),
      historyPayload,
    );
    batch.set(
      _globalHistory().doc('${userId}_created_${userBooking.id}'),
      historyPayload,
    );
    batch.set(
      _readableHistory().doc(
        _readableHistoryDocId(userId, 'created', bookingCode),
      ),
      historyPayload,
    );
    await batch.commit();
  }

  Future<void> deleteBooking(Order booking) async {
    final userId = _authService.currentUserId();
    if (userId == null) {
      throw Exception('Log in to delete bookings.');
    }

    final cancelledBooking = booking.copyWith(
      userId: userId,
      status: 'cancelled',
    );
    final bookingCode = _bookingCode(cancelledBooking);
    final historyPayload = _historyPayload(
      cancelledBooking,
      eventType: 'cancelled',
      bookingCode: bookingCode,
      userId: userId,
    );

    final batch = _firestore.batch();
    batch.delete(_bookingsForUser(userId).doc(booking.id));
    batch.set(
      _historyForUser(userId).doc('cancelled_$bookingCode'),
      historyPayload,
    );
    batch.set(
      _globalHistory().doc('${userId}_cancelled_${booking.id}'),
      historyPayload,
    );
    batch.set(
      _readableHistory().doc(
        _readableHistoryDocId(userId, 'cancelled', bookingCode),
      ),
      historyPayload,
    );
    await batch.commit();
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

  Stream<List<BookingHistoryEntry>> watchBookingHistory({int limit = 20}) {
    final userId = _authService.currentUserId();
    if (userId == null) {
      return const Stream<List<BookingHistoryEntry>>.empty();
    }

    return _historyForUser(userId)
        .orderBy('eventAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = Map<String, dynamic>.from(doc.data());
            data['id'] = doc.id;
            data['bookingId'] = data['bookingId'] ?? '';
            data['userId'] = data['userId'] ?? userId;
            data['createdAt'] = _dateString(data['createdAt']);
            data['eventAt'] = _dateString(data['eventAt']);
            data['scheduledDate'] = _nullableDateString(data['scheduledDate']);
            return BookingHistoryEntry.fromJson(data);
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

  Map<String, Object?> _historyPayload(
    Order booking, {
    required String eventType,
    required String bookingCode,
    required String userId,
  }) {
    return {
      ...booking.toJson(),
      ..._bookingSummary(booking),
      'bookingId': booking.id,
      'bookingCode': bookingCode,
      'eventType': eventType,
      'userLabel': _userLabel(userId),
      'eventAt': FieldValue.serverTimestamp(),
      'eventAtLocal': DateTime.now().toIso8601String(),
    };
  }

  String _bookingCode(Order booking) {
    final stamp = booking.createdAt;
    final y = stamp.year.toString().padLeft(4, '0');
    final m = stamp.month.toString().padLeft(2, '0');
    final d = stamp.day.toString().padLeft(2, '0');
    final hh = stamp.hour.toString().padLeft(2, '0');
    final mm = stamp.minute.toString().padLeft(2, '0');
    final shortId = booking.id
        .replaceAll('-', '')
        .substring(0, 6)
        .toUpperCase();
    return 'BKG-$y$m$d-$hh$mm-$shortId';
  }

  String _userLabel(String userId) {
    final email = _authService.currentUserEmail();
    if (email != null && email.trim().isNotEmpty) {
      return email.trim();
    }
    if (userId.length <= 8) {
      return userId;
    }
    return '${userId.substring(0, 4)}...${userId.substring(userId.length - 4)}';
  }

  String _readableHistoryDocId(
    String userId,
    String eventType,
    String bookingCode,
  ) {
    final raw = '${_userLabel(userId)}_${eventType}_$bookingCode'.toLowerCase();
    return raw.replaceAll(RegExp(r'[^a-z0-9._-]'), '_');
  }
}
