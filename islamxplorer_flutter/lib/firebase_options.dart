// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyCjmUePETT4kz7XjamG8lG1X4KbCM77E5g',
    appId: '1:89245412373:web:04871895fc6a3c7719f21c',
    messagingSenderId: '89245412373',
    projectId: 'islamxplorer',
    authDomain: 'islamxplorer.firebaseapp.com',
    storageBucket: 'islamxplorer.appspot.com',
    measurementId: 'G-T73VBNH18T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBG3mjUJ9We-UqzPFsxm6ylCo3n28N-lXI',
    appId: '1:89245412373:android:99fd86b41364a3d519f21c',
    messagingSenderId: '89245412373',
    projectId: 'islamxplorer',
    storageBucket: 'islamxplorer.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA0_9zFuxao067Re-R-qieTrzx02fAV2FM',
    appId: '1:89245412373:ios:1acddbcf3600b5f619f21c',
    messagingSenderId: '89245412373',
    projectId: 'islamxplorer',
    storageBucket: 'islamxplorer.appspot.com',
    iosBundleId: 'com.islamxplorer.islamxplorerFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA0_9zFuxao067Re-R-qieTrzx02fAV2FM',
    appId: '1:89245412373:ios:b6bc19137801534b19f21c',
    messagingSenderId: '89245412373',
    projectId: 'islamxplorer',
    storageBucket: 'islamxplorer.appspot.com',
    iosBundleId: 'com.islamxplorer.islamxplorerFlutter.RunnerTests',
  );
}