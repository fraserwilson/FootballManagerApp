import 'package:flutter/material.dart';
import 'package:screens_ui/shared/constants.dart';

class AddPlayersFo extends StatefulWidget {
  @override
  _AddPlayersFoState createState() => _AddPlayersFoState();
}

class _AddPlayersFoState extends State<AddPlayersFo> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Add Player", style: TextStyle(fontSize: 18.0)),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: textInputDecoration,
                validator: (val) => val.isEmpty ? 'Please enter a name' : null,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: textInputDecoration,
                validator: (val) =>
                    val.isEmpty ? 'Please enter a surname' : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
