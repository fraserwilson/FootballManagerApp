import 'package:flutter/material.dart';
import 'package:screens_ui/authenticate/login.dart';
import 'package:screens_ui/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showLoginIn = true;

  void toggleView() {
    setState(() => showLoginIn = !showLoginIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginIn) {
      return LoginInScreen(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
