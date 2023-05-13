import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:ghaf_application/app/preferences/shared_pref_controller.dart';
import 'package:ghaf_application/presentation/resources/routes_manager.dart';
import 'package:ghaf_application/presentation/screens/about_app_view.dart';

import 'local_notifications_service.dart';

class FirebaseMessagingService {

  static FirebaseMessagingService? _instance;
  FirebaseMessaging? _fcm;
  LocalNotificationsService? _localNotificationsService;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


  var c ;


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



  Future<void> init({required BuildContext context}) async {
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
        var ms = jsonEncode(message.toMap());
        print(notification);
        print(ms);
        // Map<String,dynamic> x = jsonEncode(message.toMap()) as Map<String, dynamic>;
        // print(x);

        if (SharedPrefController().enableNotifications) {
          _localNotificationsService?.showNotification(
            notification.title,
            notification.body,
            payload: jsonEncode(
              message.toMap(),
            ),
          );
        }

        if(c== 'ok') {
          Navigator.of(context).pushNamed(Routes.aboutAppRoute);
        }
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // on message opened app.
      if(message.data != null || message.data.isEmpty) {
        print('=====================there is data and the screen is :');
        print(message.data['screen']);
        // Get.toNamed('/${message.data['screen']}');
        c= 'ok';

      }
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
  // if(message.data != null || message.data.isEmpty) {
  //   print('=====================there is data and the screen is :');
  //   print(message.data['screen']);
  //   Get.toNamed('/${message.data['screen']}');
  //   // Navigator.of(context).pushNamed(Routes.aboutAppRoute);
  // }
  print("Handling a background message: ${message.messageId}");
}
