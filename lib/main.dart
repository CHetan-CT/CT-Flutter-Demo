import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:ct_flutter_integration/app_screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainWidget());
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CleverTapPlugin.setDebugLevel(3);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: LoginScreen()),
    );
  }
}
