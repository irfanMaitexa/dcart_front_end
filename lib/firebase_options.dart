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
    apiKey: 'AIzaSyBncREc6fjiFIcmRflsZbbISk2IvaR5geM',
    appId: '1:165727969734:web:efd5112db10620420f12c7',
    messagingSenderId: '165727969734',
    projectId: 'dgcart-ce33b',
    authDomain: 'dgcart-ce33b.firebaseapp.com',
    databaseURL: 'https://dgcart-ce33b-default-rtdb.firebaseio.com',
    storageBucket: 'dgcart-ce33b.firebasestorage.app',
    measurementId: 'G-137MN7CKRG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACox2gtccy4YvzROV1WvE5Cbj8h1HDQtw',
    appId: '1:165727969734:android:43ce7b4244aaa27a0f12c7',
    messagingSenderId: '165727969734',
    projectId: 'dgcart-ce33b',
    databaseURL: 'https://dgcart-ce33b-default-rtdb.firebaseio.com',
    storageBucket: 'dgcart-ce33b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDhVyXWBpPGVhSKrnrs1w1YYw616zeslF4',
    appId: '1:165727969734:ios:f9099e786437b9070f12c7',
    messagingSenderId: '165727969734',
    projectId: 'dgcart-ce33b',
    databaseURL: 'https://dgcart-ce33b-default-rtdb.firebaseio.com',
    storageBucket: 'dgcart-ce33b.firebasestorage.app',
    iosBundleId: 'com.example.onlineGroceryAppUi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDhVyXWBpPGVhSKrnrs1w1YYw616zeslF4',
    appId: '1:165727969734:ios:f9099e786437b9070f12c7',
    messagingSenderId: '165727969734',
    projectId: 'dgcart-ce33b',
    databaseURL: 'https://dgcart-ce33b-default-rtdb.firebaseio.com',
    storageBucket: 'dgcart-ce33b.firebasestorage.app',
    iosBundleId: 'com.example.onlineGroceryAppUi',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBncREc6fjiFIcmRflsZbbISk2IvaR5geM',
    appId: '1:165727969734:web:cd11251e821470b60f12c7',
    messagingSenderId: '165727969734',
    projectId: 'dgcart-ce33b',
    authDomain: 'dgcart-ce33b.firebaseapp.com',
    databaseURL: 'https://dgcart-ce33b-default-rtdb.firebaseio.com',
    storageBucket: 'dgcart-ce33b.firebasestorage.app',
    measurementId: 'G-54CQDC138N',
  );
}
