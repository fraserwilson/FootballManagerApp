import 'package:flutter/material.dart';
import 'package:screens_ui/login.dart';
import 'squad_list.dart';
import 'login.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either login(if user is not logged in) or squad list(if user is logged in)
    return LoginInScreen();
  }
}
