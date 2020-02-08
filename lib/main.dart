import 'package:ct_flutter_integration/app_screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MainWidget());

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text('CT Flutter Integration'),
          ),
          body: LoginScreen()),
    );
  }
}
