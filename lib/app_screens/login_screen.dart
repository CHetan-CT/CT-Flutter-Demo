import 'dart:collection';

import 'package:clevertap_plugin/clevertap_plugin.dart';
import 'package:ct_flutter_integration/app_screens/main_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  Map<String, dynamic> profile = HashMap();

  @override
  Widget build(BuildContext ctx) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('CT Flutter Integration'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              ),
            ),
            onChanged: (String name) {
              setState(() {
                profile['Name'] = name;
              });
            },
          ),
          const SizedBox(height: 16),
          TextField(
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'UserName',
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              ),
            ),
            onChanged: (String userName) {
              setState(() {
                profile['Identity'] = userName;
              });
            },
          ),
          const SizedBox(height: 16),
          TextField(
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              ),
            ),
            onChanged: (String email) {
              setState(() {
                profile['Email'] = email;
              });
            },
          ),
          const SizedBox(height: 16),
          TextField(
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Phone',
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.5),
              ),
            ),
            onChanged: (String phone) {
              setState(() {
                profile['Phone'] = phone;
              });
            },
          ),
          const SizedBox(height: 16),
          Container(
//            margin: EdgeInsets.only(top: 16, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    CleverTapPlugin.onUserLogin(profile);
                  },
                  color: Colors.blueAccent[400],
                  elevation: 6.0,
                  child: Container(
                    child: Text('On User Login',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                ),
                RaisedButton(
                  onPressed: () {
                    CleverTapPlugin.profileSet(profile);
                  },
                  elevation: 6.0,
                  color: Colors.blueAccent[400],
                  child: Container(
                    child: Text('Profile Push',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          RaisedButton(
            onPressed: () {
              CleverTapPlugin.recordEvent("Skip_login", null);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainScreen()));
            },
            elevation: 6.0,
            color: Colors.blueAccent[400],
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: const Text('SKIP >>',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
