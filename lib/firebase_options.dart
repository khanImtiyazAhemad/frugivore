import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        appId: '1:612886671653:ios:3efd8f0469f662ae566acc',
        apiKey: 'AIzaSyD58sAPCmkg2imjXhjf_CZnTOSTWZYh13E',
        projectId: 'frugivore-d50d8',
        messagingSenderId: '848951255444',
        iosBundleId: 'com.frugivore.india',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:612886671653:android:ee099257da6651ba566acc',
        apiKey: 'AIzaSyD58sAPCmkg2imjXhjf_CZnTOSTWZYh13E',
        projectId: 'frugivore-d50d8',
        messagingSenderId: '848951255444',
      );
    }
  }
}
