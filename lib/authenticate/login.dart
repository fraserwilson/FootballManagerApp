import 'package:flutter/material.dart';
import 'package:screens_ui/services/auth.dart';
import 'package:screens_ui/shared/loading.dart';
import 'package:flutter/services.dart';

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(186, 15, 48, 1),
              title: Text(
                "Login Screen",
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    ))
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
                        height: height * 0.04,
                      ),
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/genysis.png'),
                          radius: 75,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      TextFormField(
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        obscureText: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                              new RegExp(r"\s\b|\b\s"))
                        ],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black)),
                        ),
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      TextFormField(
                        validator: (val) => val.length < 6
                            ? 'Enter a password that is 6 characters long'
                            : null,
                        obscureText: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                              new RegExp(r"\s\b|\b\s"))
                        ],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black)),
                        ),
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(
                        height: height * 0.18,
                      ),
                      SizedBox(
                        width: width,
                        height: height * 0.08,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
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
                          color: Color.fromRGBO(186, 15, 48, 1),
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
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
