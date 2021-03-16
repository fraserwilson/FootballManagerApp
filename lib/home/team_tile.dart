import 'package:flutter/material.dart';
import 'package:screens_ui/home/team_players.dart';
import 'package:screens_ui/models/teams.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TeamTile extends StatelessWidget {
  final Team team;
  TeamTile({this.team});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25.0,
            backgroundImage: AssetImage('assets/team.png'),
          ),
          title: Text(
            team.teamName,
          ),
          subtitle: Text(
            'Manager: ${team.managerName}',
          ),
          onTap: () {
            print(team.docId);
            if (team.docId == FirebaseAuth.instance.currentUser.uid) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TeamPlayers()));
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        backgroundColor: Color.fromRGBO(186, 15, 48, 1),
                        scrollable: true,
                        title: Text(
                          'Warning!!!!!',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                        content: StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Please log in with team email to view this teams players',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }));
                  });
            }
          },
        ),
      ),
    );
  }
}
