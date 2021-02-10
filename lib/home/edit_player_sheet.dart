import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/models/user.dart';
import 'package:screens_ui/services/databases_players.dart';
import 'package:screens_ui/shared/loading.dart';

class EditPlayerSheet extends StatefulWidget {
  @override
  _EditPlayerSheetState createState() => _EditPlayerSheetState();
}

class _EditPlayerSheetState extends State<EditPlayerSheet> {
  final _formKey = GlobalKey<FormState>();
  final List<int> attackstat = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  final List<int> midfieldstat = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  final List<int> defensestat = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  final List<int> goalkeepingstat = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  String _currentName;
  String _currentPosition;
  int _currentAttack;
  int _currentMidfield;
  int _currentDefense;
  int _currentGoalkeeping;

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
                  Text(user.uid),
                  Text("Update your player stats.",
                      style: TextStyle(fontSize: 14.0)),
                  SizedBox(
                    height: 20.0,
                  ),
                  //Edit Name
                  TextFormField(
                    initialValue: userData.name,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //Edit Position
                  TextFormField(
                    initialValue: userData.postion,
                    validator: (val) =>
                        val.isEmpty ? 'Please enter a position' : null,
                    onChanged: (val) => setState(() => _currentPosition = val),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //Edit attack
                  DropdownButtonFormField(
                    value: _currentAttack ?? userData.attack,
                    items: attackstat.map((attack) {
                      return DropdownMenuItem(
                        value: attack,
                        child: Text('Attack Stat: Level $attack'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentAttack = val),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //Edit Midfield
                  DropdownButtonFormField(
                    value: _currentMidfield ?? userData.midfield,
                    items: midfieldstat.map((midfield) {
                      return DropdownMenuItem(
                        value: midfield,
                        child: Text('Midfield Stat: Level $midfield'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentMidfield = val),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //Edit Defense
                  DropdownButtonFormField(
                    value: _currentDefense ?? userData.defense,
                    items: defensestat.map((defense) {
                      return DropdownMenuItem(
                        value: defense,
                        child: Text('Defense Stat: Level $defense'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentDefense = val),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  //Edit Goalkeeping
                  DropdownButtonFormField(
                    value: _currentGoalkeeping ?? userData.goalkeeping,
                    items: goalkeepingstat.map((goalkeeping) {
                      return DropdownMenuItem(
                        value: goalkeeping,
                        child: Text('Goalkeeping Stat: Level $goalkeeping'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentGoalkeeping = val),
                  ),

                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      print(_currentName);
                      print(_currentPosition);
                      print(_currentAttack);
                      print(_currentMidfield);
                      print(_currentDefense);
                      print(_currentGoalkeeping);
                    },
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
