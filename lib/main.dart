import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:ct_flutter_integration/app_screens/login_screen.dart';
import 'package:ct_flutter_integration/util/firebase_setup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainWidget());
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
    FirebaseSetup().setUpFirebase();
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
