import 'package:drift/drift.dart';

import 'connection/connection.dart';

part 'app_database.g.dart';

class DbFitnessCenters extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get location => text()();
  TextColumn get description => text()();
  TextColumn get imageUrl => text().withDefault(const Constant(''))();
  TextColumn get sportType => text()();
  RealColumn get rating => real()();
  TextColumn get openingHours => text()();
  TextColumn get membershipPrice => text()();
  BoolColumn get isOpen => boolean()();
  RealColumn get distance => real()();

  @override
  String get tableName => 'fitness_centers';

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

class DbMemberships extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get centerId => integer()();
  TextColumn get name => text()();
  RealColumn get price => real()();
  TextColumn get description => text()();
  TextColumn get duration => text()();
  TextColumn get imageUrl => text().withDefault(const Constant(''))();

  @override
  String get tableName => 'memberships';
}

class DbBookings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get contactName => text()();
  DateTimeColumn get selectedDate => dateTime().nullable()();
  TextColumn get selectedTime => text().nullable()();
  TextColumn get status => text()();
  RealColumn get totalCost => real()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  String get tableName => 'bookings';
}

class DbBookingItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get bookingId => integer()();
  IntColumn get membershipId => integer()();
  IntColumn get quantity => integer()();
  RealColumn get price => real()();

  @override
  String get tableName => 'booking_items';
}

@DriftAccessor(tables: [DbFitnessCenters])
class FitnessCenterDao extends DatabaseAccessor<AppDatabase>
    with _$FitnessCenterDaoMixin {
  FitnessCenterDao(super.db);

  Future<List<DbFitnessCenter>> findAllCenters() {
    return select(db.dbFitnessCenters).get();
  }

  Stream<List<DbFitnessCenter>> watchAllCenters() {
    return select(db.dbFitnessCenters).watch();
  }

  Future<void> insertCenters(List<DbFitnessCentersCompanion> entries) async {
    await batch((batch) {
      batch.insertAll(
        db.dbFitnessCenters,
        entries,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> deleteAllCenters() {
    return delete(db.dbFitnessCenters).go();
  }
}

@DriftAccessor(tables: [DbMemberships])
class MembershipDao extends DatabaseAccessor<AppDatabase>
    with _$MembershipDaoMixin {
  MembershipDao(super.db);

  Future<List<DbMembership>> findMembershipsByCenterId(int centerId) {
    return (select(
      db.dbMemberships,
    )..where((tbl) => tbl.centerId.equals(centerId))).get();
  }

  Future<DbMembership?> findMembershipById(int membershipId) {
    return (select(
      db.dbMemberships,
    )..where((tbl) => tbl.id.equals(membershipId))).getSingleOrNull();
  }

  Stream<List<DbMembership>> watchMembershipsByCenterId(int centerId) {
    return (select(
      db.dbMemberships,
    )..where((tbl) => tbl.centerId.equals(centerId))).watch();
  }

  Future<void> insertMemberships(
    List<DbMembershipsCompanion> memberships,
  ) async {
    await batch((batch) {
      batch.insertAll(db.dbMemberships, memberships);
    });
  }

  Future<void> deleteMembershipsByCenterId(int centerId) {
    return (delete(
      db.dbMemberships,
    )..where((tbl) => tbl.centerId.equals(centerId))).go();
  }
}

@DriftAccessor(tables: [DbBookings])
class BookingDao extends DatabaseAccessor<AppDatabase> with _$BookingDaoMixin {
  BookingDao(super.db);

  Future<List<DbBooking>> findAllBookings() {
    return (select(
      db.dbBookings,
    )..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])).get();
  }

  Future<List<DbBooking>> findBookingsByUserId(String userId) {
    return (select(db.dbBookings)
          ..where((tbl) => tbl.userId.equals(userId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
        .get();
  }

  Stream<List<DbBooking>> watchAllBookings() {
    return (select(
      db.dbBookings,
    )..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)])).watch();
  }

  Stream<List<DbBooking>> watchBookingsByUserId(String userId) {
    return (select(db.dbBookings)
          ..where((tbl) => tbl.userId.equals(userId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
        .watch();
  }

  Future<int> insertBooking(DbBookingsCompanion booking) {
    return into(db.dbBookings).insert(booking);
  }

  Future<void> deleteBooking(int id) {
    return (delete(db.dbBookings)..where((tbl) => tbl.id.equals(id))).go();
  }
}

@DriftAccessor(tables: [DbBookingItems])
class BookingItemDao extends DatabaseAccessor<AppDatabase>
    with _$BookingItemDaoMixin {
  BookingItemDao(super.db);

  Future<List<DbBookingItem>> findItemsByBookingId(int bookingId) {
    return (select(
      db.dbBookingItems,
    )..where((tbl) => tbl.bookingId.equals(bookingId))).get();
  }

  Future<void> insertBookingItems(
    List<DbBookingItemsCompanion> bookingItems,
  ) async {
    await batch((batch) {
      batch.insertAll(db.dbBookingItems, bookingItems);
    });
  }

  Future<void> deleteItemsByBookingId(int bookingId) {
    return (delete(
      db.dbBookingItems,
    )..where((tbl) => tbl.bookingId.equals(bookingId))).go();
  }
}

@DriftDatabase(
  tables: [DbFitnessCenters, DbMemberships, DbBookings, DbBookingItems],
  daos: [FitnessCenterDao, MembershipDao, BookingDao, BookingItemDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  AppDatabase.forTesting(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;
}
