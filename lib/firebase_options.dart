// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDGyfWuyYjUX5f2hQsm0ETphycdAQSVpVQ',
    appId: '1:825228249566:web:82daefed513f81c2e5754f',
    messagingSenderId: '825228249566',
    projectId: 'simchat-c5730',
    authDomain: 'simchat-c5730.firebaseapp.com',
    storageBucket: 'simchat-c5730.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDG8EW6squ4y41WUU8JA5PXfzUZS8M-LS8',
    appId: '1:825228249566:android:e806ee86b1c3eb83e5754f',
    messagingSenderId: '825228249566',
    projectId: 'simchat-c5730',
    storageBucket: 'simchat-c5730.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAn04tcbiKK9aiN8MyLo6bhBO3Bknt4LlQ',
    appId: '1:825228249566:ios:8b39183f1e4ea80ee5754f',
    messagingSenderId: '825228249566',
    projectId: 'simchat-c5730',
    storageBucket: 'simchat-c5730.firebasestorage.app',
    iosBundleId: 'com.example.schat',
  );
}
