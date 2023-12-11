// ignore_for_file: no_default_cases

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

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
    apiKey: 'AIzaSyCGA_dIViPg5I26Dsp37OiChKqcE_FdQLw',
    appId: '1:1036205428938:android:c97ecb64ec26cee168e433',
    messagingSenderId: '1036205428938',
    projectId: 'premed-mobile-app',
    storageBucket: 'premed-mobile-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDWA_0B_UQfFxxy5mZI12Cft2UcHPyKshU',
    appId: '1:1036205428938:ios:772355393cb6a5f568e433',
    messagingSenderId: '1036205428938',
    projectId: 'premed-mobile-app',
    storageBucket: 'premed-mobile-app.appspot.com',
    iosClientId:
        '1036205428938-oomnrs6bm8dnbmduhhbjp3hiagdpqjer.apps.googleusercontent.com',
    iosBundleId: 'com.example.premedpkMobileApp',
  );
}
