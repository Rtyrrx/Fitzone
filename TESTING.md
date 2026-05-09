# Testing Guide

## Commands

Run all unit and widget tests:

```bash
flutter test
```

Run the integration test:

```bash
flutter test integration_test
```

Run tests with coverage:

```bash
flutter test --coverage
```

Generate or refresh golden files:

```bash
flutter test test/golden --update-goldens
```

## What Each Test Covers

- `test/unit/booking_manager_test.dart`: cart and booking logic such as add, remove, totals, and empty state.
- `test/unit/auth_validation_test.dart`: email and password validation without calling Firebase.
- `test/unit/fitness_center_model_test.dart`: `FitnessCenter.fromJson()` and `toJson()`.
- `test/unit/membership_model_test.dart`: `MembershipPlan.fromJson()` and `toJson()`.
- `test/unit/db_repository_test.dart`: optional in-memory Drift booking insert, load, and delete flow.
- `test/widget/login_page_test.dart`: login form rendering and validation messages.
- `test/widget/booking_page_test.dart`: booking rendering, delete callback flow, and empty state.
- `test/widget/fitness_center_card_test.dart`: fitness center card content and navigation behavior.
- `test/golden/login_page_golden_test.dart`: visual snapshot of the login page.
- `test/golden/fitness_center_card_golden_test.dart`: visual snapshot of a fitness center card.
- `integration_test/app_flow_test.dart`: end-to-end user flow from login to visible booking.

## Manual Testing Checklist

- Open the app and confirm the login screen renders correctly.
- Try empty login fields and confirm validation messages appear.
- Log in and verify navigation reaches the home tab.
- Open a fitness center and confirm membership plans are visible.
- Add a membership to the booking drawer and submit it.
- Open the Bookings tab and confirm the booking is listed.
- Delete a booking and confirm it disappears.
- If Firebase is configured, confirm real auth/chat still work as before.
- If Firebase is not configured, confirm local test login still lets the app be explored.
