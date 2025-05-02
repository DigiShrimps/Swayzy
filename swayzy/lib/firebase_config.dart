import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

FirebaseOptions get firebaseConfig {
  if (kIsWeb) {
    return FirebaseOptions(
      apiKey: dotenv.env['WEB_API_KEY']!,
      appId: dotenv.env['WEB_APP_ID']!,
      messagingSenderId: dotenv.env['WEB_SENDER_ID']!,
      projectId: dotenv.env['PROJECT_ID']!,
      storageBucket: dotenv.env['STORAGE_BUCKET']!,
      authDomain: dotenv.env['AUTH_DOMAIN']!,
      measurementId: dotenv.env['MEASUREMENT_ID']!,
    );
  }

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return FirebaseOptions(
        apiKey: dotenv.env['ANDROID_API_KEY']!,
        appId: dotenv.env['ANDROID_APP_ID']!,
        messagingSenderId: dotenv.env['ANDROID_SENDER_ID']!,
        projectId: dotenv.env['PROJECT_ID']!,
        storageBucket: dotenv.env['STORAGE_BUCKET']!,
      );
    default:
      throw UnsupportedError('Platform not supported for FirebaseOptions');
  }
}