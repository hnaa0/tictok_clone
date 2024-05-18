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
    apiKey: 'AIzaSyDWrn7nXgbqHqZDcd9mv1DqRj05yAUvOR8',
    appId: '1:814614352930:web:75a985646516bb3891267b',
    messagingSenderId: '814614352930',
    projectId: 'tiktokclone-lec-nc',
    authDomain: 'tiktokclone-lec-nc.firebaseapp.com',
    storageBucket: 'tiktokclone-lec-nc.appspot.com',
    measurementId: 'G-3ZQZ9CR65E',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChSqHEn6KZUdcfWy6_5j9E7YtI3WANkjg',
    appId: '1:814614352930:android:cce80eec9f1e591391267b',
    messagingSenderId: '814614352930',
    projectId: 'tiktokclone-lec-nc',
    storageBucket: 'tiktokclone-lec-nc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC7u6DQ-tUT0X-VrDejpG5H4OzYBwuDjQE',
    appId: '1:814614352930:ios:2afe59533d8dbf0d91267b',
    messagingSenderId: '814614352930',
    projectId: 'tiktokclone-lec-nc',
    storageBucket: 'tiktokclone-lec-nc.appspot.com',
    iosBundleId: 'com.example.tiktokClone',
  );

}