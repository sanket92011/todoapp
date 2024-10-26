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
    apiKey: 'AIzaSyAHp-vUTsEFa_ixMOw-hznvhB6_GFtAcFg',
    appId: '1:136094123028:web:7e423b0d01ad7490375301',
    messagingSenderId: '136094123028',
    projectId: 'todo-beb3f',
    authDomain: 'todo-beb3f.firebaseapp.com',
    storageBucket: 'todo-beb3f.appspot.com',
    measurementId: 'G-KWE2Q4ND7X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9RK9qoERt4ljHNyy6EJNsKeniwtVXBYs',
    appId: '1:136094123028:android:c005dee6f2373493375301',
    messagingSenderId: '136094123028',
    projectId: 'todo-beb3f',
    storageBucket: 'todo-beb3f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDWv9NlNLAz6-cFK06aAS4SiVI-qjYr_HE',
    appId: '1:136094123028:ios:ccc726bca8194b45375301',
    messagingSenderId: '136094123028',
    projectId: 'todo-beb3f',
    storageBucket: 'todo-beb3f.appspot.com',
    iosBundleId: 'com.example.todoapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDWv9NlNLAz6-cFK06aAS4SiVI-qjYr_HE',
    appId: '1:136094123028:ios:ccc726bca8194b45375301',
    messagingSenderId: '136094123028',
    projectId: 'todo-beb3f',
    storageBucket: 'todo-beb3f.appspot.com',
    iosBundleId: 'com.example.todoapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAHp-vUTsEFa_ixMOw-hznvhB6_GFtAcFg',
    appId: '1:136094123028:web:a83107315c1b3f93375301',
    messagingSenderId: '136094123028',
    projectId: 'todo-beb3f',
    authDomain: 'todo-beb3f.firebaseapp.com',
    storageBucket: 'todo-beb3f.appspot.com',
    measurementId: 'G-GELCSV9R14',
  );
}
