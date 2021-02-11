import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:screens_ui/shared/constants.dart';

class AddPlayersFo extends StatefulWidget {
  @override
  _AddPlayersFoState createState() => _AddPlayersFoState();
}

class _AddPlayersFoState extends State<AddPlayersFo> {
  final _formKey = GlobalKey<FormState>();

  //form values
  String _playerName;
  String _playerSurname;
  int _attackStat;
  int _midfieldStat;
  int _defenseStat;
  int _goalkeppingStat;
  bool _isAvaliable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: <Widget>[
                Text("Add Player", style: TextStyle(fontSize: 18.0)),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
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
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  )),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter a surname' : null,
                  onChanged: (val) => setState(() => _playerSurname = val),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text("Attack Stat", style: TextStyle(fontSize: 12.0)),
                Slider(
                  value: (_attackStat ?? 100).toDouble(),
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) => setState(() => _attackStat = val.round()),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text("Midfield Stat", style: TextStyle(fontSize: 12.0)),
                Slider(
                  value: (_midfieldStat ?? 100).toDouble(),
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) =>
                      setState(() => _midfieldStat = val.round()),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text("Defense Stat", style: TextStyle(fontSize: 12.0)),
                Slider(
                  value: (_defenseStat ?? 100).toDouble(),
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) =>
                      setState(() => _defenseStat = val.round()),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text("Goalkeeping Stat", style: TextStyle(fontSize: 12.0)),
                Slider(
                  value: (_goalkeppingStat ?? 100).toDouble(),
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) =>
                      setState(() => _goalkeppingStat = val.round()),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text('Is this player avaliable?'),
                Checkbox(
                    tristate: false,
                    value: _isAvaliable,
                    onChanged: (bool value) {
                      setState(() {
                        _isAvaliable = value;
                      });
                    }),
                RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      print(_playerName);
                      print(_playerSurname);
                      print(_attackStat);
                      print(_midfieldStat);
                      print(_defenseStat);
                      print(_goalkeppingStat);
                      print(_isAvaliable);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
