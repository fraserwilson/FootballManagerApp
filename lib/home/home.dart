import 'package:flutter/material.dart';
import 'package:screens_ui/home/settings_form.dart';
import 'package:screens_ui/home/team_list.dart';
import 'package:screens_ui/models/teams.dart';
import 'package:screens_ui/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/services/databases_teams.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  bool counterAttack = false;
  bool tikiTaka = false;
  bool longBalls = false;
  bool fourFourTwo = false;
  bool fourThreeThree = false;
  bool threeFiveTwo = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var firebaseUser = FirebaseAuth.instance.currentUser.email;
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
          endDrawer: Container(
            width: width,
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          firebaseUser,
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
                      trailing: Icon(Icons.play_arrow, color: Colors.black),
                      title: Text('Playstyles'),
                      onTap: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                scrollable: true,
                                title: Text('Playstyles'),
                                content: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Form(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: ListTile(
                                              tileColor: counterAttack
                                                  ? Color.fromRGBO(
                                                      186, 15, 48, 1)
                                                  : Colors.white,
                                              leading: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 25.0,
                                                  backgroundImage: AssetImage(
                                                      'assets/running.jpg')),
                                              title: Text('Counter-Attack',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18)),
                                              subtitle: Text(
                                                  'Fast, reactive free-flowing play',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16)),
                                              onTap: () {
                                                setState(() {
                                                  counterAttack =
                                                      !counterAttack;
                                                  tikiTaka = false;
                                                  longBalls = false;
                                                });
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: ListTile(
                                              tileColor: tikiTaka
                                                  ? Color.fromRGBO(
                                                      186, 15, 48, 1)
                                                  : Colors.white,
                                              leading: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 25.0,
                                                  backgroundImage: AssetImage(
                                                      'assets/passing.png')),
                                              title: Text('Tiki-Taka',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18)),
                                              subtitle: Text(
                                                  'Short passes, with the intent to break down opposition teams',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16)),
                                              onTap: () {
                                                setState(() {
                                                  tikiTaka = !tikiTaka;
                                                  longBalls = false;
                                                  counterAttack = false;
                                                });
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: ListTile(
                                              tileColor: longBalls
                                                  ? Color.fromRGBO(
                                                      186, 15, 48, 1)
                                                  : Colors.white,
                                              leading: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 25.0,
                                                  backgroundImage: AssetImage(
                                                      'assets/crossing.png')),
                                              title: Text('Long balls',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18)),
                                              subtitle: Text(
                                                  'Constant crosses into the box, generally after absorbing large amounts of pressure',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16)),
                                              onTap: () {
                                                setState(() {
                                                  longBalls = !longBalls;
                                                  tikiTaka = false;
                                                  counterAttack = false;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }));
                          },
                        );
                      }),
                  ListTile(
                      trailing: Icon(Icons.group, color: Colors.black),
                      title: Text('Formations'),
                      onTap: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: Text('Team Formations'),
                              content: StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter setState) {
                                  return Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Form(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: ListTile(
                                              tileColor: fourFourTwo
                                                  ? Color.fromRGBO(
                                                      186, 15, 48, 1)
                                                  : Colors.white,
                                              leading: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 25.0,
                                                  backgroundImage: AssetImage(
                                                      'assets/442.jpg')),
                                              title: Text('4-4-2',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18)),
                                              subtitle: Text(
                                                '4 defenders, 4 midfielders, 2 forwards',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  fourFourTwo = !fourFourTwo;
                                                  fourThreeThree = false;
                                                  threeFiveTwo = false;
                                                });
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: ListTile(
                                              tileColor: fourThreeThree
                                                  ? Color.fromRGBO(
                                                      186, 15, 48, 1)
                                                  : Colors.white,
                                              leading: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 25.0,
                                                  backgroundImage: AssetImage(
                                                      'assets/433.jpg')),
                                              title: Text('4-3-3',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18)),
                                              subtitle: Text(
                                                  '4 defenders, 3 midfielders, 3 forwards',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16)),
                                              onTap: () {
                                                setState(() {
                                                  fourThreeThree =
                                                      !fourThreeThree;
                                                  fourFourTwo = false;
                                                  threeFiveTwo = false;
                                                });
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: ListTile(
                                              tileColor: threeFiveTwo
                                                  ? Color.fromRGBO(
                                                      186, 15, 48, 1)
                                                  : Colors.white,
                                              leading: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 25.0,
                                                  backgroundImage: AssetImage(
                                                      'assets/352.png')),
                                              title: Text('3-5-2',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18)),
                                              subtitle: Text(
                                                  '3 defenders, 5 midfielders, 2 forwards',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16)),
                                              onTap: () {
                                                setState(() {
                                                  threeFiveTwo = !threeFiveTwo;
                                                  fourFourTwo = false;
                                                  fourThreeThree = false;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
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
              style: TextStyle(color: Colors.white),
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
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
