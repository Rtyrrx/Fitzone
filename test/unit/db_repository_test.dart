import 'package:chapter3/services/shared_prefs_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/mock_services.dart';
import '../helpers/test_data.dart';

void main() {
  group('DBRepository in-memory persistence', () {
    late FakeRepository repository;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      await SharedPrefsService.instance.ensureInitialized();
      await SharedPrefsService.instance.prefs.clear();
      repository = FakeRepository();
      await repository.init();
      await repository.setCurrentUserId(fakeUser.id);
    });

    tearDown(() async {
      await repository.close();
    });

    test('insert, retrieve, and delete booking', () async {
      final booking = buildFakeBooking(userId: fakeUser.id);

      await repository.saveBooking(booking);

      final savedBookings = await repository.getBookings();
      expect(savedBookings, hasLength(1));
      expect(savedBookings.single.memberName, 'Test Member');
      expect(savedBookings.single.items.single.item.name, fakeMembership.name);

      await repository.deleteBooking(savedBookings.single.databaseId!);

      final remainingBookings = await repository.getBookings();
      expect(remainingBookings, isEmpty);
    });
  });
}
