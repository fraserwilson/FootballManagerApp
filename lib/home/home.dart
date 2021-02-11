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
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Team>>.value(
      value: DatabaseService().teams,
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('Team List'),
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
              FlatButton.icon(
                  onPressed: () => _showSettingsPanel(),
                  icon: Icon(Icons.settings),
                  label: Text('Settings'))
            ],
          ),
          body: TeamList(),
        ),
      ),
    );
  }
}
