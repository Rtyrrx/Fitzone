import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'Firebase is not configured for iOS. Run flutterfire configure and '
          'select iOS to generate ios/Runner/GoogleService-Info.plist.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'Firebase is not configured for macOS. Run flutterfire configure and '
          'select macOS to generate macOS/Runner/GoogleService-Info.plist.',
        );
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        throw UnsupportedError(
          'Firebase is not configured for this desktop platform. Run '
          'flutterfire configure and select this platform first.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDD8hwFewXDuj-_5u13uC1TXyhd3IeJ8v8',
    appId: '1:359196195395:android:21e2ce7456ba07d10972f6',
    messagingSenderId: '359196195395',
    projectId: 'fitnesscentersapp',
    databaseURL:
        'https://fitnesscentersapp-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fitnesscentersapp.firebasestorage.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB1hCJi7uM1yF5IZnUG5cq2Y2IxVr1vcFI',
    appId: '1:359196195395:web:8611ba98ef0e42e70972f6',
    messagingSenderId: '359196195395',
    projectId: 'fitnesscentersapp',
    authDomain: 'fitnesscentersapp.firebaseapp.com',
    databaseURL:
        'https://fitnesscentersapp-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fitnesscentersapp.firebasestorage.app',
  );
}
