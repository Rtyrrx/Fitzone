import 'package:chapter3/widgets/restaurant_landscape_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../helpers/test_data.dart';

void main() {
  testGoldens('fitness center card matches golden', (tester) async {
    final center = buildFakeFitnessCenter();

    await tester.pumpWidgetBuilder(
      Material(
        child: Center(
          child: SizedBox(
            width: 340,
            child: FitnessCenterLandscapeCard(
              fitnessCenter: center,
              centerId: center.id,
              currentTab: 0,
              isFavorite: false,
              onFavoriteToggle: () async {},
              fullWidth: true,
            ),
          ),
        ),
      ),
      wrapper: materialAppWrapper(
        theme: ThemeData(useMaterial3: true),
      ),
      surfaceSize: const Size(420, 320),
    );

    await screenMatchesGolden(tester, 'fitness_center_card');
  });
}
