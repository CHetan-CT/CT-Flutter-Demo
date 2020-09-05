import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:ct_flutter_integration/app_screens/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await handleBox();
  runApp(MainWidget());
}

Future<void> handleBox() async {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
    },
    onBackgroundMessage: myBackgroundMessageHandler,
    onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    },
    onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    },
  );
  print("fcm........");
  // print(box.get("fcm"));
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  print("coming");
  // Hive.init(directory.path);
  // Box box = await Hive.openBox("fcm");
  // box.put("fcm", "from Hive ${message.toString()}");
  print("hello world");
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
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
    // CleverTapPlugin.createNotification(data);
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeApp();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: LoginScreen()),
    );
  }

  void initializeApp() {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.getToken().then((token) {
      CleverTapPlugin.setPushToken(token); // Sending token to CleverTap
    });

    CleverTapPlugin.createNotificationChannel(
      'channel_1',
      'CT_Test',
      'Channel to test notifications from CT Dashboard',
      5,
      true,
    );

    // FirebaseSetup().setUpFirebase();
    CleverTapPlugin.setDebugLevel(3);

    CleverTapPlugin.setOptOut(false);
    CleverTapPlugin.setOffline(false);
    CleverTapPlugin.enableDeviceNetworkInfoReporting(true);
//    CleverTapPlugin.enablePersonalization(); // ????
//    CleverTapPlugin.disablePersonalization(); // ????
    CleverTapPlugin.recordScreenView('Main_Screen'); //Probably for the Website

    CleverTapPlugin.setLocation(19.1743281, 72.8424023);
  }
}
