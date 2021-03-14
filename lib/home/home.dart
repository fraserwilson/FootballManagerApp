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
          endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Options',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CircleAvatar(
                        backgroundColor: Color.fromRGBO(186, 15, 48, 1),
                        backgroundImage: AssetImage('assets/genysis.png'),
                        radius: 40,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(186, 15, 48, 1),
                  ),
                ),
                ListTile(
                    trailing: Icon(Icons.settings, color: Colors.black),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.pop(context);
                      _showSettingsPanel();
                    }),
                ListTile(
                    trailing: Icon(Icons.person, color: Colors.black),
                    title: Text('Logout'),
                    onTap: () async {
                      Navigator.pop(context);
                      await _auth.signOut();
                    }),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(186, 15, 48, 1),
            leading: CircleAvatar(
              backgroundColor: Color.fromRGBO(186, 15, 48, 1),
              backgroundImage: AssetImage('assets/genysis.png'),
              radius: 40,
            ),
            title: Text(
              'Team List',
              style: TextStyle(color: Colors.white, fontFamily: 'SyneMono'),
            ),
            centerTitle: true,
            elevation: 0.0,
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
