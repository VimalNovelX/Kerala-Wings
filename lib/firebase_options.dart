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
    apiKey: 'AIzaSyDwbQfQ-8YYfZTWT2rPDQY7vKuV0U0v8pI',
    appId: '1:142500878085:web:aaf99e38ddb572a47c496c',
    messagingSenderId: '142500878085',
    projectId: 'keralawings-96197',
    authDomain: 'keralawings-96197.firebaseapp.com',
    storageBucket: 'keralawings-96197.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCjQGSSaCcKiSIB_iyI5RbXPNiV3_ld41s',
    appId: '1:142500878085:android:da9bceb52eb810f67c496c',
    messagingSenderId: '142500878085',
    projectId: 'keralawings-96197',
    storageBucket: 'keralawings-96197.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCK8zwgaF1wUjW6Kr7OeeYQXK5pxZCuve4',
    appId: '1:142500878085:ios:dee63dcb714af70a7c496c',
    messagingSenderId: '142500878085',
    projectId: 'keralawings-96197',
    storageBucket: 'keralawings-96197.appspot.com',
    iosBundleId: 'com.xpectcorps.keralaWings',
  );
}
