import 'dart:async';
import 'dart:convert';

import 'package:synchronized/synchronized.dart';

import '../../models/cart_item.dart';
import '../../models/order.dart';
import '../../models/restaurant.dart';
import '../../models/restaurant_item.dart';
import '../../services/mock_yummy_service.dart';
import '../../services/shared_prefs_service.dart';
import '../database/app_database.dart';
import '../database/model_mappers.dart';

class DBRepository {
  DBRepository(this._database, this._seedService);

  static const String _bookingsBackupKey = 'fitzone_bookings_backup';

  final AppDatabase _database;
  final MockFitnessService _seedService;
  final Lock _lock = Lock();
  final StreamController<List<Order>> _bookingsController =
      StreamController<List<Order>>.broadcast();
  final StreamController<List<FitnessCenter>> _centersController =
      StreamController<List<FitnessCenter>>.broadcast();

  StreamSubscription<List<DbBooking>>? _bookingSubscription;
  StreamSubscription<List<DbFitnessCenter>>? _centerSubscription;
  String _currentUserId = 'local-user';
  bool _initialized = false;
  bool _closed = false;

  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await _lock.synchronized(() async {
      if (_initialized) {
        return;
      }

      _watchCurrentUserBookings();
      _centerSubscription = _database.fitnessCenterDao.watchAllCenters().listen(
        (_) {
          unawaited(_emitCenters());
        },
      );

      final centers = await _database.fitnessCenterDao.findAllCenters();
      if (centers.isEmpty) {
        final seedData = await _seedService.getExploreData();
        await _saveCentersUnlocked(seedData.fitnessCenters);
        await _emitCenters();
      } else {
        await _emitCenters();
      }

      await _restoreBookingsFromBackupIfNeeded(_currentUserId);
      await _emitBookings();
      _initialized = true;
    });
  }

  Future<void> setCurrentUserId(String? userId) async {
    final normalized = userId == null || userId.trim().isEmpty
        ? 'local-user'
        : userId.trim();
    if (_currentUserId == normalized && _initialized) {
      return;
    }
    _currentUserId = normalized;
    if (_initialized) {
      await _lock.synchronized(() async {
        await _bookingSubscription?.cancel();
        _watchCurrentUserBookings();
        await _restoreBookingsFromBackupIfNeeded(_currentUserId);
        await _emitBookings();
      });
    }
  }

  void _watchCurrentUserBookings() {
    _bookingSubscription = _database.bookingDao
        .watchBookingsByUserId(_currentUserId)
        .listen((_) {
          unawaited(_emitBookings());
        });
  }

  Future<void> close() async {
    if (_closed) {
      return;
    }
    _closed = true;
    await _bookingSubscription?.cancel();
    await _centerSubscription?.cancel();
    await _bookingsController.close();
    await _centersController.close();
    await _database.close();
  }

  Future<List<FitnessCenter>> getCenters() async {
    final centerRows = await _database.fitnessCenterDao.findAllCenters();
    final result = <FitnessCenter>[];
    for (final centerRow in centerRows) {
      final memberships = await getMembershipsForCenter(centerRow.id);
      result.add(centerRow.toModel(memberships));
    }
    return result;
  }

  Stream<List<FitnessCenter>> watchCenters() async* {
    await init();
    yield await getCenters();
    yield* _centersController.stream;
  }

  Future<void> saveCenters(List<FitnessCenter> centers) async {
    await _lock.synchronized(() async {
      await _saveCentersUnlocked(centers);
      await _emitCenters();
    });
  }

  Future<List<MembershipPlan>> getMembershipsForCenter(int centerId) async {
    final rows = await _database.membershipDao.findMembershipsByCenterId(
      centerId,
    );
    return rows.map((row) => row.toModel()).toList();
  }

  Future<void> saveMemberships(
    int centerId,
    List<MembershipPlan> memberships,
  ) async {
    await _database.membershipDao.deleteMembershipsByCenterId(centerId);
    if (memberships.isEmpty) {
      await _emitCenters();
      return;
    }
    await _database.membershipDao.insertMemberships(
      memberships
          .map(
            (membership) =>
                membership.toMembershipCompanion(centerId: centerId),
          )
          .toList(),
    );
    await _emitCenters();
  }

  Future<List<Order>> getBookings() async {
    final rows = await _database.bookingDao.findBookingsByUserId(
      _currentUserId,
    );
    final bookings = <Order>[];
    for (final row in rows) {
      bookings.add(await _hydrateBooking(row));
    }
    return bookings;
  }

  Stream<List<Order>> watchBookings() async* {
    await init();
    yield await getBookings();
    yield* _bookingsController.stream;
  }

  Future<void> saveBooking(Order booking) async {
    await _lock.synchronized(() async {
      await _insertBookingUnlocked(booking.copyWith(userId: _currentUserId));
      await _emitBookings();
      await _saveBookingsBackup(await getBookings());
    });
  }

  Future<void> deleteBooking(int bookingId) async {
    await _lock.synchronized(() async {
      await _database.bookingItemDao.deleteItemsByBookingId(bookingId);
      await _database.bookingDao.deleteBooking(bookingId);
      await _emitBookings();
      await _saveBookingsBackup(await getBookings());
    });
  }

  Future<void> _insertBookingUnlocked(Order booking) async {
    final bookingId = await _database.bookingDao.insertBooking(
      booking.toBookingCompanion(),
    );
    if (booking.items.isEmpty) {
      return;
    }
    await _database.bookingItemDao.insertBookingItems(
      booking.items
          .map((item) => item.toBookingItemCompanion(bookingId: bookingId))
          .toList(),
    );
  }

  Future<void> _restoreBookingsFromBackupIfNeeded(String userId) async {
    final existingBookings = await _database.bookingDao.findBookingsByUserId(
      userId,
    );
    if (existingBookings.isNotEmpty) {
      await _saveBookingsBackup(await getBookings());
      return;
    }

    final backup = _loadBookingsBackup(userId);
    if (backup.isEmpty) {
      return;
    }

    for (final booking in backup) {
      await _insertBookingUnlocked(booking);
    }
  }

  List<Order> _loadBookingsBackup(String userId) {
    final storedBookings =
        SharedPrefsService.instance.prefs.getStringList(
          SharedPrefsService.instance.userKey(_bookingsBackupKey, userId),
        ) ??
        const [];
    final bookings = <Order>[];
    for (final bookingJson in storedBookings) {
      try {
        bookings.add(
          Order.fromJson(jsonDecode(bookingJson) as Map<String, dynamic>),
        );
      } catch (_) {
        // Ignore corrupt backup entries; the database remains the source of truth.
      }
    }
    return bookings;
  }

  Future<void> _saveBookingsBackup(List<Order> bookings) async {
    await SharedPrefsService.instance.prefs.setStringList(
      SharedPrefsService.instance.userKey(_bookingsBackupKey, _currentUserId),
      bookings.map((booking) => jsonEncode(booking.toJson())).toList(),
    );
  }

  Future<void> _emitCenters() async {
    if (_centersController.isClosed) {
      return;
    }
    final centers = await getCenters();
    _centersController.sink.add(centers);
  }

  Future<void> _emitBookings() async {
    if (_bookingsController.isClosed) {
      return;
    }
    final bookings = await getBookings();
    _bookingsController.sink.add(bookings);
  }

  Future<void> _saveCentersUnlocked(List<FitnessCenter> centers) async {
    await _database.fitnessCenterDao.deleteAllCenters();
    await _database.fitnessCenterDao.insertCenters(
      centers.map((center) => center.toCenterCompanion()).toList(),
    );
    for (final center in centers) {
      await _database.membershipDao.deleteMembershipsByCenterId(center.id);
      if (center.memberships.isEmpty) {
        continue;
      }
      await _database.membershipDao.insertMemberships(
        center.memberships
            .map(
              (membership) =>
                  membership.toMembershipCompanion(centerId: center.id),
            )
            .toList(),
      );
    }
  }

  Future<Order> _hydrateBooking(DbBooking row) async {
    final itemRows = await _database.bookingItemDao.findItemsByBookingId(
      row.id,
    );
    final items = <CartItem>[];
    for (final itemRow in itemRows) {
      final membershipRow = await _database.membershipDao.findMembershipById(
        itemRow.membershipId,
      );
      MembershipPlan membership;
      if (membershipRow != null) {
        membership = membershipRow.toModel();
      } else {
        membership = MembershipPlan(
          id: itemRow.membershipId,
          name: 'Saved Membership',
          price: itemRow.price,
          description: 'Persisted booking membership',
        );
      }
      items.add(itemRow.toModel(membership));
    }
    return row.toModel(items);
  }
}
