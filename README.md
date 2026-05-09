# FitZone Flutter App

This project improves an existing Flutter fitness centers app by adding a Smart Discovery feature, improving profile functionality, and refining the overall UI while preserving the original app structure and navigation flow.

## What I Added

- Smart search for fitness centers by name, sport type, and address
- Fast filters: `Open now`, `Top rated`, `Within 2 km`, and `Favorites`
- Sorting options: `Nearest`, `Rating`, and `Price`
- Favorites system for saving preferred fitness centers
- Horizontal premium-style fitness center carousel with web scroll buttons
- Editable profile photo with 11 local face assets
- Working profile actions: edit profile, change language, set weekly goal, change payment method, help/support
- More friend activity posts using local image assets
- More fitness centers for each sport type

## What I Changed

- Improved the main page UI to look more modern and premium
- Restored the first fitness center section to horizontal scrolling
- Improved the design of center cards, post cards, and app theme
- Made profile settings functional instead of visual-only
- Replaced unreliable external avatar links with local assets from the `images` folder
- Kept the original app structure, routing, login flow, bookings flow, and detail pages working

## Animations Used

1. `AnimatedSwitcher`
- Used for tab/page switching in `lib/screens/home.dart`
- Used for filtered results switching in `lib/components/restaurant_section.dart`
- Used for favorite icon animation in `lib/widgets/restaurant_landscape_card.dart`
- Used for favorite icon animation in `lib/screens/restaurant_page.dart`
- Reference: https://api.flutter.dev/flutter/widgets/AnimatedSwitcher-class.html

2. `FadeTransition`
- Used inside `AnimatedSwitcher` transitions in `lib/screens/home.dart`
- Used inside `AnimatedSwitcher` transitions in `lib/components/restaurant_section.dart`
- Used inside favorite icon transitions in `lib/widgets/restaurant_landscape_card.dart`
- Used inside favorite icon transitions in `lib/screens/restaurant_page.dart`
- Reference: https://api.flutter.dev/flutter/widgets/FadeTransition-class.html

3. `SizeTransition`
- Used in filtered results transition in `lib/components/restaurant_section.dart`
- Reference: https://api.flutter.dev/flutter/widgets/SizeTransition-class.html

4. `ScaleTransition`
- Used for favorite button pop animation in `lib/widgets/restaurant_landscape_card.dart`
- Used for favorite button pop animation in `lib/screens/restaurant_page.dart`
- Reference: https://api.flutter.dev/flutter/widgets/ScaleTransition-class.html

5. `AnimatedScale`
- Used for selected sport-type emphasis in `lib/components/category_section.dart`
- Reference: https://api.flutter.dev/flutter/widgets/AnimatedScale-class.html

6. `Hero`
- Used for transition from center card to center details page in `lib/widgets/restaurant_landscape_card.dart`
- Used for transition in `lib/screens/restaurant_page.dart`
- Reference: https://api.flutter.dev/flutter/widgets/Hero-class.html

7. `ScrollController.animateTo`
- Used for horizontal section navigation buttons in `lib/components/restaurant_section.dart`
- Used for sport type scrolling in `lib/components/category_section.dart`
- Reference: https://api.flutter.dev/flutter/widgets/ScrollController/animateTo.html

## Other Flutter UI Features Used

- `SearchAnchor`: https://api.flutter.dev/flutter/material/SearchAnchor-class.html
- `FilterChip`: https://api.flutter.dev/flutter/material/FilterChip-class.html
- `SegmentedButton`: https://api.flutter.dev/flutter/material/SegmentedButton-class.html
- `Badge`: https://api.flutter.dev/flutter/material/Badge-class.html
- `SliverAppBar`: https://api.flutter.dev/flutter/material/SliverAppBar-class.html

## Conclusion

The final result improves usability, search speed, personalization, and overall interface quality of the fitness centers app while preserving the existing project structure and functionality.

## Testing Report

- I added testing support to my existing Flutter fitness center app without creating a new project or rewriting the app.
- I updated `pubspec.yaml` and added the testing packages I needed:
  - `integration_test`
  - `mocktail`
  - `golden_toolkit`
- I organized the testing structure into:
  - `test/unit`
  - `test/widget`
  - `test/helpers`
  - `test/golden`
  - `integration_test`
- For unit tests, I covered:
  - booking/cart logic
  - auth validation
  - `FitnessCenter` JSON serialization
  - `MembershipPlan` JSON serialization
  - in-memory Drift booking insert, retrieve, and delete flow
- For widget tests, I covered:
  - login page rendering and validation
  - booking page list, delete flow, and empty state
  - fitness center card display and tap navigation
- For golden tests, I added visual snapshot tests for:
  - login page
  - fitness center card
- For integration testing, I created one full user flow:
  - app start
  - login
  - open home
  - open fitness center
  - choose membership
  - create booking
  - verify booking appears in My Bookings
- I added fake test data and mock services so the tests do not depend on:
  - real Firebase
  - real Firestore
  - real internet
  - real persistent database data
- I made a few small production changes to improve testability:
  - added reusable auth validation
  - turned login into a proper form with validation
  - added stable widget keys
  - added local fallback login when Firebase is not configured
  - added in-memory Drift database support for tests
- I created `TESTING.md` with commands for:
  - normal test runs
  - integration tests
  - coverage
  - golden updates
- What succeeded:
  - `flutter test` passed
  - golden tests passed
  - unit, widget, and golden setup is complete
  - integration test file is ready
- One note:
  - the integration test could not be run in this environment because only a web device was available, and Flutter integration tests need a supported non-web device or emulator
- Overall, I completed a clean, simple, assignment-ready testing setup for the existing app.

## Firestore Rule Note

Recommended Firestore rule for the `fitness_messages` collection:

```text
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /fitness_messages/{messageId} {
      allow read, write: if request.auth != null;
    }
  }
}
```
