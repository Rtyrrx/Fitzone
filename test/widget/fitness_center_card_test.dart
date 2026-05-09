import 'package:chapter3/widgets/restaurant_landscape_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../helpers/test_data.dart';

void main() {
  testWidgets('card displays center details and supports navigation', (
    tester,
  ) async {
    final center = buildFakeFitnessCenter();
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return Material(
              child: Center(
                child: FitnessCenterLandscapeCard(
                  fitnessCenter: center,
                  centerId: center.id,
                  currentTab: 0,
                  isFavorite: false,
                  onFavoriteToggle: () async {},
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: '/0/center/1',
          builder: (context, state) {
            return const Scaffold(body: Center(child: Text('Center details')));
          },
        ),
      ],
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();

    expect(find.text(center.name), findsOneWidget);
    expect(find.text(center.address), findsOneWidget);
    expect(find.text(center.rating.toString()), findsOneWidget);

    await tester.tap(find.text(center.name));
    await tester.pumpAndSettle();

    expect(find.text('Center details'), findsOneWidget);
  });
}
