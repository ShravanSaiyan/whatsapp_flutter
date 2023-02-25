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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBiZQPKw2EFQOTwrhN8sR1HpAjEIVRs3KA',
    appId: '1:793671473410:android:06bd1efd8b6ec15856ca1b',
    messagingSenderId: '793671473410',
    projectId: 'whatsapp-backend-7e46e',
    storageBucket: 'whatsapp-backend-7e46e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRNIsvJa1ZWtZWC4t8CRlI6RhSpSSsh8I',
    appId: '1:793671473410:ios:55e70bda9624721956ca1b',
    messagingSenderId: '793671473410',
    projectId: 'whatsapp-backend-7e46e',
    storageBucket: 'whatsapp-backend-7e46e.appspot.com',
    iosClientId: '793671473410-q9fkr3a8ca1gh6o9crc54jji3cm6jt6r.apps.googleusercontent.com',
    iosBundleId: 'com.example.whatsappFlutter',
  );
}