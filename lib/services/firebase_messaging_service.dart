import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';

import 'local_notifications_service.dart';

class FirebaseMessagingService {
  static FirebaseMessagingService? _instance;
  FirebaseMessaging? _fcm;
  LocalNotificationsService? _localNotificationsService;

  FirebaseMessagingService._() {
    _fcm = FirebaseMessaging.instance;
    _localNotificationsService = LocalNotificationsService.instance;
  }

  // ||.. singleton pattern ..||
  static FirebaseMessagingService get instance {
    if (_instance != null) return _instance!;
    return _instance = FirebaseMessagingService._();
  }

  Future<String?> getToken() async {
    return _fcm?.getToken();
  }

  Future<void> init() async {
    await _fcm?.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    String? token = await getToken();
    print('fcm token : $token');
    FirebaseMessaging.instance.subscribeToTopic('ghaf');
    FirebaseMessaging.onMessage.listen((message) {
      // on message.
      print('======================================i');
      print('on message');
      print(message.notification.toString());
      print(message.data.toString());
      print(message.notification?.title);
      print(message.notification?.body);
      print(message);
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        print('=====================================enableNotifications');
        print(SharedPrefController().enableNotifications);
        print('======================noti');
        print(notification);
        print(jsonEncode(
          message.toMap(),
        ));
        // Map<String,dynamic> x = jsonEncode(message.toMap()) as Map<String, dynamic>;
        // print(x);
        _localNotificationsService?.showNotification(
          notification.title,
          notification.body,
          payload: jsonEncode(
            message.toMap(),
          ),
        );
        if (SharedPrefController().enableNotifications) {}
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // on message opened app.
      print('on message opened app');
      print(message.notification?.title);
      print(message.notification?.body);
      // _localNotificationsService!
      //     .onNotificationTapped(jsonEncode(message.toMap()));
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // after opening notification when app is terminated.
    // RemoteMessage? remoteMessage =
    //     await FirebaseMessaging.instance.getInitialMessage();
    // if (remoteMessage != null) {
    //   AppSharedData.appOpenedBy = AppOpenedBy.notification;
    //   AppSharedData.sharedPreferencesController!.getUserData();
    //   _localNotificationsService!
    //       .onNotificationTapped(jsonEncode(remoteMessage.toMap()));
    // }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // on background.
  print("Handling a background message: ${message.messageId}");
}
