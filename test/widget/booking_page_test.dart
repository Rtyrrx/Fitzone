import 'package:chapter3/models/order.dart';
import 'package:chapter3/screens/mybookings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/test_data.dart';

class MockDeleteBookingCallback extends Mock {
  Future<void> call(Order order);
}

void main() {
  late Order booking;

  setUpAll(() {
    registerFallbackValue(buildFakeBooking());
  });

  setUp(() {
    booking = buildFakeBooking(
      type: BookingType.scheduled,
      scheduledDate: DateTime(2026, 5, 20),
      scheduledTime: '6:30 PM',
    );
  });

  testWidgets('shows an existing booking', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MyBookingsPage(
          bookings: [booking],
          isLoading: false,
          error: null,
          onDeleteBooking: (_) async {},
        ),
      ),
    );

    expect(find.text('My Bookings'), findsOneWidget);
    expect(find.text('Member: Test Member'), findsOneWidget);
    expect(find.text('Monthly Pro x1'), findsOneWidget);
    expect(find.textContaining('Total: \$49.99'), findsOneWidget);
  });

  testWidgets('delete booking button calls the expected callback', (
    tester,
  ) async {
    final callback = MockDeleteBookingCallback();
    when(() => callback.call(any())).thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: MyBookingsPage(
          bookings: [booking],
          isLoading: false,
          error: null,
          onDeleteBooking: callback.call,
        ),
      ),
    );

    await tester.tap(find.byTooltip('Cancel booking'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Yes, Cancel'));
    await tester.pumpAndSettle();

    verify(() => callback.call(booking)).called(1);
  });

  testWidgets('shows empty state when there are no bookings', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MyBookingsPage(
          bookings: const [],
          isLoading: false,
          error: null,
          onDeleteBooking: (_) async {},
        ),
      ),
    );

    expect(find.text('No bookings yet'), findsOneWidget);
    expect(find.text('Book a session at a fitness center'), findsOneWidget);
  });
}
