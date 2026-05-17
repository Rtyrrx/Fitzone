README_FitZone_Assignment.md
# FitZone Assignment Update — Chapter 19 + Firebase Bookings

This is my final update record for the FitZone fitness centers app. The app was originally built through the previous Flutter chapters, and for this assignment I focused on two main requirements: **platform-specific app assets from Chapter 19** and a **Firebase/Firestore booking history feature**.

The goal was not to rebuild the whole app from scratch. I kept the existing fitness project and added the missing parts needed for the assignment.

---

## 1. Chapter 19 — Platform-Specific App Assets

For Chapter 19, I updated the branding of the app so it no longer looks like a default Flutter project.

I generated and implemented new visual assets for the app:

- A custom **FitZone app icon**
- A custom **FitZone splash/loading logo**
- A more modern, minimal fitness-style look
- Navy and blue colors to match the fitness/gym theme
- A clean “F” logo connected to the FitZone brand

These assets can still be swapped later if needed. For now, I used them as the project branding assets.

### What I changed

- I added the new app icon asset.
- I added the splash/loading logo asset.
- I updated the app name/branding to FitZone.
- I prepared the assets so they can be used for launcher icons and splash screen setup.

### Screenshot included

I will include these screenshots for this part:

1. <img width="300" height="600" alt="logo" src="https://github.com/user-attachments/assets/34a759b7-4649-40da-aa3b-2f97ccb6b2b1" />
2. <img width="200" height="200" alt="icon" src="https://github.com/user-attachments/assets/8fb0de89-88f3-4c32-a4c5-b13ff27035d6" />


These screenshots show that the app is no longer using the default Flutter branding and now has its own fitness-themed identity.

---

## 2. Firebase Feature — Booking History in Firestore

The second main requirement I worked on was Firebase integration. Instead of only keeping booking data inside the app, I connected the app with **Firebase Firestore** so booking history can be saved remotely.

I chose to focus Firebase on the **booking history** feature because it makes sense for my app. FitZone is a fitness centers app, so users should be able to book memberships or sessions, and their bookings should be saved.

### What the Firebase feature does

- Each user can make a booking in the app.
- The booking can be saved to Firestore.
- Firestore stores the booking data as cloud data.
- This means bookings are not just temporary UI data.
- The booking history can be viewed and verified from Firebase Console.

### Why I chose bookings

I chose bookings because it is one of the core features of the app. A fitness app should remember what the user booked, such as a membership or session. Saving this to Firestore makes the app more realistic because the data can exist outside the local device.

### What kind of data is saved

The booking data can include fields like:

- User ID or user email
- Booking ID
- Selected membership
- Booking date
- Booking time
- Booking status
- Total cost
- Created date/time

This makes Firestore act like a simple cloud database for the booking history.

---

## 3. Screenshots I Will Include

I will include seven screenshots in total:

1. <img width="1484" height="652" alt="Screenshot 2026-05-18 003622" src="https://github.com/user-attachments/assets/6dac4b58-6e9a-4b43-b74b-68c4d8bf2ea6" /> 

2. <img width="1865" height="945" alt="Screenshot 2026-05-18 003610" src="https://github.com/user-attachments/assets/140bc41c-346c-4985-a7e5-ab823f98a06f" />

3. <img width="1866" height="939" alt="Screenshot 2026-05-18 003714" src="https://github.com/user-attachments/assets/5e5ef3b2-0738-48d6-9a74-dd75b300c5df" />

4. <img width="1484" height="652" alt="Screenshot 2026-05-18 004516" src="https://github.com/user-attachments/assets/626e7703-2899-4bce-8e9b-bb2cf2e9fb29" />

5. <img width="1493" height="656" alt="Screenshot 2026-05-18 004531" src="https://github.com/user-attachments/assets/80afbeae-c303-423c-99f6-791f9fe24be4" />

6.  <img width="1492" height="657" alt="Screenshot 2026-05-18 004541" src="https://github.com/user-attachments/assets/2420883a-b1d0-4b9b-9981-c3b1052ca4ee" />

7.  <img width="1493" height="655" alt="Screenshot 2026-05-18 004549" src="https://github.com/user-attachments/assets/0e354eb2-b8c8-4087-b78b-a49760669a00" />


These screenshots prove both parts of the assignment: the visual asset update and the Firebase data feature.

---

## 4. What I Implemented Overall

In this update, I worked on:

- Custom branding for the app
- FitZone app icon
- FitZone splash/loading logo
- Chapter 19 platform-specific asset setup
- Firebase connection
- Firestore booking history
- Saving bookings for users
- Showing booking records inside the app
- Verifying booking data inside Firebase Console

---

## 5. Short Explanation

This assignment update improves both the appearance and the backend behavior of my app.

The Chapter 19 part improves how the app looks on the device by replacing the default Flutter identity with my own FitZone branding. The Firebase part improves the data side of the project by saving user bookings to Firestore, so booking history can be stored and checked outside the app.

So overall, I added a more complete app identity and connected one important app feature, bookings, to Firebase.

---

## 6. Final Notes

This is still a student project, so I kept the implementation simple and focused on the assignment requirements. The assets can be replaced later, and the Firebase booking structure can also be improved later if the app becomes bigger.

For now, the main point is that:

- The app has its own FitZone branding.
- The app has custom Chapter 19 assets.
- Firebase is used for a real feature.
- User bookings can be saved and checked in Firestore.



# Testing Report

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
