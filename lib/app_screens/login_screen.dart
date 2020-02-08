import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          children: <Widget>[
            TextField(
              obscureText: false,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(hintText: 'Identity'),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: onUserLogin(),
                      elevation: 2,
                      child: Text('On User Login'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16),
                    ),
                    RaisedButton(
                      onPressed: profilePush(),
                      elevation: 2,
                      child: Text('Profile Push'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onUserLogin() {}

  profilePush() {}
}
