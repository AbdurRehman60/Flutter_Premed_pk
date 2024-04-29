import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:premedpk_mobile_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  if (kDebugMode) {
    print(
      message.notification,
    );
  }
}

class FirebaseMessagingAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Important Notifications',
    importance: Importance.high,
    enableLights: true,
    description: "This Channel is used for important notifications",
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    try {
      await FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    } catch (e) {
      if (kDebugMode) {
        print("Error handling initial message: $e");
      }
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(message);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen(
      (message) {
        final notification = message.notification;
        if (notification == null) {
          return;
        }
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@mipmap/ic_notification_icon',
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      },
    );
  }

  Future<void> initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android =
        AndroidInitializationSettings('@mipmap/ic_notification_icon');
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (playload) {
        final message = RemoteMessage.fromMap(jsonDecode(playload.payload!));
        handleMessage(message);
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    await Future.delayed(const Duration(seconds: 1));
    final fCMToken = await _firebaseMessaging.getToken();
    if (fCMToken != null) {
      if (kDebugMode) {
        print('This is the Token $fCMToken');
      }
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcmToken', fCMToken);
      await _firebaseMessaging.subscribeToTopic('allDownloads');
      initPushNotifications();
      initLocalNotifications();
    } else {
      if (kDebugMode) {
        print('Failed to get FCM token');
      }
    }
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    }

    navigatorKey.currentState?.pushNamed("/MarketPlace");
  }
}
