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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  TextFormField(
                    initialValue: _currentTeamName ?? userData.teamName,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      hintText: 'Team Name',
                      hintStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black)),
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a team name' : null,
                    onChanged: (val) => setState(() => _currentTeamName = val),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  TextFormField(
                    initialValue: _currentManagerName ?? userData.managerName,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      hintText: 'Manager Name',
                      hintStyle: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black)),
                    ),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter your managers name' : null,
                    onChanged: (val) =>
                        setState(() => _currentManagerName = val),
                  ),
                  SizedBox(
                    height: height * 0.07,
                  ),
                  SizedBox(
                    height: height * 0.08,
                    width: width,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Color.fromRGBO(186, 15, 48, 1),
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
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
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
