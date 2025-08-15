import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:frugivore/firebase_options.dart';
import 'package:frugivore/services/notification.dart';
import 'package:frugivore/globals.dart' as globals;
import 'package:frugivore/utils.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
          name: "frugivore", options: DefaultFirebaseOptions.currentPlatform);
    }
  } on FirebaseException catch (e) {
    throw Exception(e.toString());
  }
}

AndroidNotificationChannel? channel;

FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance = PushNotificationsManager._();

  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  bool _initialized = false;
  static String? token = "Push Notification";

  Future<void> init() async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(name: "frugivore", options: DefaultFirebaseOptions.currentPlatform);
      }
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    }
    if (!_initialized) {
      await requestPermission();
      _initialized = true;
      await getToken();
    }
  }

  Future<void> listeners() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        !.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    handlePushNotificationEvents();
  }

  Future<void> requestPermission() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  Future<void> getToken() async {
    token = await messaging.getToken();
  }

  void handlePushNotificationEvents() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
      if (android != null) {
        flutterLocalNotificationsPlugin?.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel!.id,
                channel!.name,
                icon: 'launch_background',
                priority: Priority.high,
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      Map<String, dynamic> data = message.data;
      var response = await Services.readNotification(data['id']);
      if (response != null) {
        int count = int.parse(globals.payload['notification']);
        if (count > 0) {
          globals.payload['notification'] = (count - 1).toString();
          globals.payload.refresh();
        }
        PromotionBannerRouting(url: data['redirect']).routing();
      } else {
        Navigator.pushNamed(Get.context!, data['redirect']);
      }
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {
        Map<String, dynamic> data = message.data;
        var response = await Services.readNotification(data['id']);
        if (response != null) {
          int count = int.parse(globals.payload['notification']);
          if (count > 0) {
            globals.payload['notification'] = (count - 1).toString();
            globals.payload.refresh();
          }
          PromotionBannerRouting(url: data['redirect']).routing();
        } else {
          Navigator.pushNamed(Get.context!, data['redirect']);
        }
      }
    });
  }
}
