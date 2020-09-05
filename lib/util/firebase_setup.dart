import 'dart:developer';
import 'dart:io';

import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseSetup {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  FirebaseMessaging _firebaseMessaging;

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.getToken().then((token) {
      CleverTapPlugin.setPushToken(token); // Sending token to CleverTap
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        log('on message $message');

        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
            'channel_1',
            'CT_Test',
            'Channel to test notifications from CT Dashboard',
            importance: Importance.Max,
            priority: Priority.High);
        var iOSPlatformChannelSpecifics = IOSNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
            androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

        flutterLocalNotificationsPlugin.show(
            0, 'Message', 'plain body', platformChannelSpecifics,
            payload: 'item x');
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
            'channel_1',
            'CT_Test',
            'Channel to test notifications from CT Dashboard',
            importance: Importance.Max,
            priority: Priority.High);
        var iOSPlatformChannelSpecifics = IOSNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
            androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

        flutterLocalNotificationsPlugin.show(
            0, 'resume', 'plain body', platformChannelSpecifics,
            payload: 'item x');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch $message');
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
            'channel_1',
            'CT_Test',
            'Channel to test notifications from CT Dashboard',
            importance: Importance.Max,
            priority: Priority.High);
        var iOSPlatformChannelSpecifics = IOSNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
            androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

        flutterLocalNotificationsPlugin.show(
            0, 'Launch', 'plain body', platformChannelSpecifics,
            payload: 'item x');
      },
    );
  }

  Future displayNotification(Map<String, dynamic> message) async {
//    await flutterLocalNotificationsPlugin.show(
//      0,
//      message['notification']['title'],
//      message['notification']['body'],
//      platformChannelSpecifics,
//      payload: 'hello',
//    );
  }

  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));

    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      CleverTapPlugin.registerForPush(); //Registering for Push on iOS
      print("Settings registered: $settings");
    });
  }

  void setUpFirebase() {
    _firebaseMessaging = FirebaseMessaging();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    CleverTapPlugin.createNotificationChannel(
      'channel_1',
      'CT_Test',
      'Channel to test notifications from CT Dashboard',
      5,
      true,
    );

    firebaseCloudMessagingListeners();
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      log(data);

      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'channel_1',
          'CT_Test',
          'Channel to test notifications from CT Dashboard',
          importance: Importance.Max,
          priority: Priority.High);
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

      flutterLocalNotificationsPlugin.show(
          0, 'Background', 'Data', platformChannelSpecifics,
          payload: 'item x');
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      log(notification);

      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'channel_1',
          'CT_Test',
          'Channel to test notifications from CT Dashboard',
          importance: Importance.Max,
          priority: Priority.High);
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

      flutterLocalNotificationsPlugin.show(
          0, 'Background', 'Notification', platformChannelSpecifics,
          payload: 'item x');
    }
    return Future<void>.value();
  }
}
