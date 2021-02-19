import 'package:flutter/material.dart';
import 'package:screens_ui/services/auth.dart';
import 'package:screens_ui/shared/loading.dart';
//import '../squad_list.dart';

class LoginInScreen extends StatefulWidget {
  final Function toggleView;
  LoginInScreen({this.toggleView});
  @override
  _LoginInScreenState createState() => _LoginInScreenState();
}

class _LoginInScreenState extends State<LoginInScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field states
  String email = '';
  String password = '';
  String error = ' ';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Login Screen"),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Register"))
              ],
            ),
            body: Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50.0,
                      ),
                      Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/soccerball.jpg'),
                          radius: 60.0,
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        obscureText: false,
                        style: TextStyle(fontSize: 20.0),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: 'Username',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(70.0)),
                        ),
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        validator: (val) => val.length < 6
                            ? 'Enter a password that is 6 characters long'
                            : null,
                        obscureText: true,
                        style: TextStyle(fontSize: 20.0),
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                        ),
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Material(
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(30.0),
                        child: MaterialButton(
                          padding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _authService
                                  .signInWithEmailandPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  error =
                                      'Could not sign in with those credintials';
                                  loading = false;
                                });
                              }
                            }
                          },
                          color: Colors.blue,
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
