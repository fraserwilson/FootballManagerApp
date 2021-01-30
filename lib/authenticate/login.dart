import 'package:flutter/material.dart';
import 'package:screens_ui/services/auth.dart';
import '../squad_list.dart';

class LoginInScreen extends StatefulWidget {
  @override
  _LoginInScreenState createState() => _LoginInScreenState();
}

class _LoginInScreenState extends State<LoginInScreen> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          Center(
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/soccerball.jpg'),
              backgroundColor: Colors.white,
              radius: 60.0,
            ),
          ),
          SizedBox(
            height: 50.0,
          ),
          TextField(
            obscureText: false,
            style: TextStyle(fontSize: 20.0),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: 'Username',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(70.0)),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          TextField(
            obscureText: true,
            style: TextStyle(fontSize: 20.0),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: 'Password',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            child: MaterialButton(
              padding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0),
              onPressed: () async {
                dynamic result = await _authService.signInAnon();
                if (result == null) {
                  print("error signing in");
                } else {
                  print("User signed in");
                  print(result.uid);
                }
                //navigateToSquadList(context);
              },
              color: Colors.black,
              child: Text(
                "Login",
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
