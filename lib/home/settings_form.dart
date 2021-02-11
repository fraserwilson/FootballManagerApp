import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/models/user.dart';
import 'package:screens_ui/services/databases_teams.dart';
import 'package:screens_ui/shared/constants.dart';
import 'package:screens_ui/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  String _currentTeamName;
  String _currentManagerName;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ConvertedUser>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your teams settings',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: _currentTeamName ?? userData.teamName,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a team name' : null,
                    onChanged: (val) => setState(() => _currentTeamName = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    initialValue: _currentManagerName ?? userData.managerName,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter your managers name' : null,
                    onChanged: (val) =>
                        setState(() => _currentManagerName = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentTeamName ?? userData.teamName,
                            _currentManagerName ?? userData.managerName);
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}