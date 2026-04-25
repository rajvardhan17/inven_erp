import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io' show Platform;

class FirebaseConfig {
  static FirebaseOptions get options {
    if (Platform.isAndroid) {
      return _android;
    } else if (Platform.isIOS) {
      return _ios;
    } else {
      return _web;
    }
  }

  // 🌐 WEB
  static FirebaseOptions get _web => FirebaseOptions(
    apiKey: dotenv.env['WEB_API_KEY']!,
    appId: dotenv.env['WEB_APP_ID']!,
    messagingSenderId: dotenv.env['WEB_SENDER_ID']!,
    projectId: dotenv.env['WEB_PROJECT_ID']!,
    authDomain: dotenv.env['WEB_AUTH_DOMAIN'],
    storageBucket: dotenv.env['WEB_STORAGE_BUCKET'],
  );

  // 🤖 ANDROID
  static FirebaseOptions get _android => FirebaseOptions(
    apiKey: dotenv.env['ANDROID_API_KEY']!,
    appId: dotenv.env['ANDROID_APP_ID']!,
    messagingSenderId: dotenv.env['ANDROID_SENDER_ID']!,
    projectId: dotenv.env['ANDROID_PROJECT_ID']!,
    storageBucket: dotenv.env['ANDROID_STORAGE_BUCKET'],
  );

  // 🍎 IOS
  static FirebaseOptions get _ios => FirebaseOptions(
    apiKey: dotenv.env['IOS_API_KEY']!,
    appId: dotenv.env['IOS_APP_ID']!,
    messagingSenderId: dotenv.env['IOS_SENDER_ID']!,
    projectId: dotenv.env['IOS_PROJECT_ID']!,
    storageBucket: dotenv.env['IOS_STORAGE_BUCKET'],
    iosBundleId: dotenv.env['IOS_BUNDLE_ID'],
  );
}
