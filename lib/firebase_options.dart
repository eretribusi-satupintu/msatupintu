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
    apiKey: 'AIzaSyBTRN3B7z5Umkx4Q0B9IosYuzj5qs3V3Dc',
    appId: '1:877717055442:web:8b09738ebc5c642f314a0b',
    messagingSenderId: '877717055442',
    projectId: 'satupintu-otp',
    authDomain: 'satupintu-otp.firebaseapp.com',
    storageBucket: 'satupintu-otp.appspot.com',
    measurementId: 'G-ZJZCK7ZREE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjGcvZ8j5IdJbK69xcfxxMiktgfxcbYoY',
    appId: '1:877717055442:android:d7224829dd9b2a9c314a0b',
    messagingSenderId: '877717055442',
    projectId: 'satupintu-otp',
    storageBucket: 'satupintu-otp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOwlqLIDnPJNm-3My8rvfReC7_p-tecfY',
    appId: '1:877717055442:ios:fb129595d0519ab7314a0b',
    messagingSenderId: '877717055442',
    projectId: 'satupintu-otp',
    storageBucket: 'satupintu-otp.appspot.com',
    iosBundleId: 'com.example.satupintuApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAOwlqLIDnPJNm-3My8rvfReC7_p-tecfY',
    appId: '1:877717055442:ios:fb129595d0519ab7314a0b',
    messagingSenderId: '877717055442',
    projectId: 'satupintu-otp',
    storageBucket: 'satupintu-otp.appspot.com',
    iosBundleId: 'com.example.satupintuApp',
  );

}