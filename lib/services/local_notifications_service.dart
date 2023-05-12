import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ghaf_application/services/firebase_messaging_service.dart';

class LocalNotificationsService {
  static LocalNotificationsService? _instance;
  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;
  late FirebaseMessagingService _firebaseMessagingService;
  int _id = 0;

  // ||.. private constructor ..||
  LocalNotificationsService._() {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  }

  // ||.. singleton pattern ..||
  static LocalNotificationsService get instance {
    if (_instance != null) return _instance!;
    return _instance = LocalNotificationsService._();
  }

  //init.
  Future<void> init() async {
    await _initLocalNotifications();
  }

  // local notifications init.
  Future<void> _initLocalNotifications() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await _flutterLocalNotificationsPlugin?.initialize(
      initializationSettings,
      // onSelectNotification: onNotificationTapped,
    );
  }

  void _onDidReceiveLocalNotification(
      num id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
//    showDialog(
//      context: _context,
//      builder: (BuildContext context) => CupertinoAlertDialog(
//        title: Text(title),
//        content: Text(body),
//        actions: [
//          CupertinoDialogAction(
//            isDefaultAction: true,
//            child: Text('Ok'),
//            onPressed: () async {
//              NS.back();
////              await Navigator.push(
////                context,
////                MaterialPageRoute(
////                  builder: (context) => SecondScreen(payload),
////                ),
////              );
//            },
//          )
//        ],
//      ),
//    );
  }

  // on notification tapped.
  Future onNotificationTapped(String? payload) async {
    debugPrint('starting [onNotificationTapped][LocalNotificationsService]...');
    debugPrint('payload : $payload');
    if (payload == null) return;
    if (payload != null) {
      print('=========================Done navigat from the app');
      print(payload);
      Get.toNamed('/${payload}');
    }

    // RemoteMessage message = RemoteMessage.fromMap(jsonDecode(payload));
    // int? chatRoomId = int.tryParse(message.data['chat_room_id'] ?? '');
    // int? receiverId = int.tryParse(message.data['send_to'] ?? '');
    // int? tripId = int.tryParse(message.data['trip_id'] ?? '');
    // int? tripType = int.tryParse(message.data['trip_type'] ?? '');
    // if (chatRoomId != null &&
    //     receiverId != null &&
    //     tripId != null &&
    //     tripType != null) {
    //   N.offAllNamed(Constants.SCREENS_MAIN_SCREEN);
    //   N.toNamed(
    //     Constants.SCREENS_CONVERSATION_SCREEN,
    //     arguments: {
    //       'chatRoomId': chatRoomId.toString(),
    //       'receiverId': receiverId.toString(),
    //       'tripId': tripId.toString(),
    //       'tripType': tripType.toString(),
    //     },
    //   );
    // } else {
    //   if (AppSharedData.appOpenedBy == AppOpenedBy.notification) {
    //     if (AppSharedData.currentUser == null) {
    //       N.offAllNamed(Constants.SCREENS_SELECT_COUNTRY_SCREEN);
    //     } else {
    //       N.offAllNamed(Constants.SCREENS_MAIN_SCREEN);
    //     }
    //   }
    // }
  }

  // ||... show local notification ...||
  void showNotification(String? title, String? message, {String? payload}) {
    _flutterLocalNotificationsPlugin?.show(
      ++_id,
      title,
      message,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'ghafId',
          'ghaf',

          enableVibration: true,
          icon: 'logo2',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: payload,
    );
  }
}
