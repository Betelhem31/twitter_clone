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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBXNopKC37xXB3SsXTeae2ShJfKU_SihrA',
    appId: '1:666062134370:web:43413d4f248c265596c53b',
    messagingSenderId: '666062134370',
    projectId: 'offical-twitter-bc63e',
    authDomain: 'offical-twitter-bc63e.firebaseapp.com',
    storageBucket: 'offical-twitter-bc63e.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDX2dfuSM22OQhSfLQjvqzBH9duG4HB5gA',
    appId: '1:666062134370:android:a89f47e24cf3d22d96c53b',
    messagingSenderId: '666062134370',
    projectId: 'offical-twitter-bc63e',
    storageBucket: 'offical-twitter-bc63e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBlCFttOnnfWuT2gT0yZbAVvDFntiPvFcI',
    appId: '1:666062134370:ios:6d0b443bb7d3037d96c53b',
    messagingSenderId: '666062134370',
    projectId: 'offical-twitter-bc63e',
    storageBucket: 'offical-twitter-bc63e.firebasestorage.app',
    iosBundleId: 'com.example.twitterClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBlCFttOnnfWuT2gT0yZbAVvDFntiPvFcI',
    appId: '1:666062134370:ios:6d0b443bb7d3037d96c53b',
    messagingSenderId: '666062134370',
    projectId: 'offical-twitter-bc63e',
    storageBucket: 'offical-twitter-bc63e.firebasestorage.app',
    iosBundleId: 'com.example.twitterClone',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBXNopKC37xXB3SsXTeae2ShJfKU_SihrA',
    appId: '1:666062134370:web:5d935c3e72d71c7296c53b',
    messagingSenderId: '666062134370',
    projectId: 'offical-twitter-bc63e',
    authDomain: 'offical-twitter-bc63e.firebaseapp.com',
    storageBucket: 'offical-twitter-bc63e.firebasestorage.app',
  );

}