import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/models/players.dart';
import 'package:screens_ui/models/user.dart';
import 'package:screens_ui/services/database_players.dart';
import 'package:screens_ui/shared/constants.dart';
import 'package:screens_ui/shared/loading.dart';

class EditPlayersForSheet extends StatefulWidget {
  @override
  _EditPlayersForSheetState createState() => _EditPlayersForSheetState();
}

class _EditPlayersForSheetState extends State<EditPlayersForSheet> {
  final _formKey = GlobalKey<FormState>();
  String _playerName;
  String _playerPosition;
  int _attackStat = 1;
  int _midfieldStat = 1;
  int _defenseStat = 1;
  int _goalkeppingStat = 1;
  bool _isAvaliable = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ConvertedUser>(context);
    return SingleChildScrollView(
      child: StreamBuilder<PlayerData>(
          stream: PlayerDatabaseService(uid: user.uid).playerData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              PlayerData playerData = snapshot.data;
              return Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text("Edit Player", style: TextStyle(fontSize: 18.0)),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        initialValue: playerData.name,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                        validator: (val) =>
                            val.isEmpty ? 'Please enter a name' : null,
                        onChanged: (val) => setState(() => _playerName = val),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        initialValue: playerData.position,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        )),
                        validator: (val) =>
                            val.isEmpty ? 'Please enter a position' : null,
                        onChanged: (val) =>
                            setState(() => _playerPosition = val),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Attack Stat", style: TextStyle(fontSize: 12.0)),
                      Slider(
                        value: (_attackStat ?? playerData.attack).toDouble(),
                        min: 1,
                        max: 10,
                        divisions: 9,
                        onChanged: (val) =>
                            setState(() => _attackStat = val.round()),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Midfield Stat", style: TextStyle(fontSize: 12.0)),
                      Slider(
                        value:
                            (_midfieldStat ?? playerData.midfield).toDouble(),
                        min: 1,
                        max: 10,
                        divisions: 9,
                        onChanged: (val) =>
                            setState(() => _midfieldStat = val.round()),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Defense Stat", style: TextStyle(fontSize: 12.0)),
                      Slider(
                        value: (_defenseStat ?? playerData.defense).toDouble(),
                        min: 1,
                        max: 10,
                        divisions: 9,
                        onChanged: (val) =>
                            setState(() => _defenseStat = val.round()),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text("Goalkeeping Stat",
                          style: TextStyle(fontSize: 12.0)),
                      Slider(
                        value: (_goalkeppingStat ?? playerData.goalkeeping)
                            .toDouble(),
                        min: 1,
                        max: 10,
                        divisions: 9,
                        onChanged: (val) =>
                            setState(() => _goalkeppingStat = val.round()),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text('Is this player avaliable?'),
                      Checkbox(
                          tristate: false,
                          value: _isAvaliable ?? playerData.isAvaliable,
                          onChanged: (bool value) {
                            setState(() {
                              _isAvaliable = value;
                            });
                          }),
                      RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await PlayerDatabaseService(
                                      uid: snapshot.data.uid)
                                  .updateUserData(
                                      _playerName ?? playerData.name,
                                      _playerPosition ?? playerData.position,
                                      _attackStat ?? playerData.attack,
                                      _midfieldStat ?? playerData.midfield,
                                      _defenseStat ?? playerData.defense,
                                      _goalkeppingStat ??
                                          playerData.goalkeeping,
                                      _isAvaliable ?? playerData.isAvaliable);
                              Navigator.pop(context);
                            }
                          })
                    ],
                  ));
            } else {
              return Loading();
            }
          }),
    );
  }
}
