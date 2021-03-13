import 'package:flutter/material.dart';
import 'package:screens_ui/home/settings_form.dart';
import 'package:screens_ui/home/team_list.dart';
import 'package:screens_ui/models/teams.dart';
import 'package:screens_ui/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/services/databases_teams.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Team>>.value(
      value: DatabaseService().teams,
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(186, 15, 48, 1),
            title: Text(
              'Team List',
              style: TextStyle(color: Colors.white, fontFamily: 'SyneMono'),
            ),
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: Text(
                  'logout',
                  style: TextStyle(color: Colors.white, fontFamily: 'SyneMono'),
                ),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
              FlatButton.icon(
                  onPressed: () => _showSettingsPanel(),
                  icon: Icon(Icons.settings, color: Colors.white),
                  label: Text('Settings',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'SyneMono')))
            ],
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              TeamList(),
              SizedBox(
                height: height * 0.02,
              ),
              Text(
                'Please tap on team tile to view players',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontFamily: 'SyneMono'),
              )
            ],
          )),
        ),
      ),
    );
  }
}
