import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (Platform.isIOS || Platform.isMacOS) {
      return ios;
    } else if (Platform.isAndroid) {
      return android;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static FirebaseOptions ios = const FirebaseOptions(
    apiKey: 'YOUR_API_KEY',
    appId: 'YOUR_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_STORAGE_BUCKET',
    iosClientId: 'YOUR_IOS_CLIENT_ID',
    iosBundleId: 'YOUR_IOS_BUNDLE_ID',
  );

  static FirebaseOptions android = const FirebaseOptions(
      apiKey: "AIzaSyCP84k6g3-yZmqMe0YLGSeO46_Pqh5j67c",
      appId: "1:718653914660:android:f6b2cc3e9f724394de22b1",
      messagingSenderId: "718653914660",
      projectId: "firbb-ec507");
}
