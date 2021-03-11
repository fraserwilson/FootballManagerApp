import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/home/home.dart';
import 'package:screens_ui/models/user.dart';
import 'authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ConvertedUser>(context);
    print(user);

    //return either login(if user is not logged in) or squad list(if user is logged in)
    if (user == null) {
      return Home();
    } else {
      return Home();
    }
  }
}
