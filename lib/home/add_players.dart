import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/shared/constants.dart';
import 'package:screens_ui/models/user.dart';

class AddPlayersFo extends StatefulWidget {
  @override
  _AddPlayersFoState createState() => _AddPlayersFoState();
}

class _AddPlayersFoState extends State<AddPlayersFo> {
  final _formKey = GlobalKey<FormState>();

  //form values
  String _playerName;
  String _playerPosition;
  int _attackStat;
  int _midfieldStat;
  int _defenseStat;
  int _goalkeppingStat;
  bool _isAvaliable = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ConvertedUser>(context);
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
                      val.isEmpty ? 'Please enter a position' : null,
                  onChanged: (val) => setState(() => _playerPosition = val),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text("Attack Stat", style: TextStyle(fontSize: 12.0)),
                Slider(
                  value: (_attackStat ?? 1).toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  onChanged: (val) => setState(() => _attackStat = val.round()),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text("Midfield Stat", style: TextStyle(fontSize: 12.0)),
                Slider(
                  value: (_midfieldStat ?? 1).toDouble(),
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
                  value: (_defenseStat ?? 1).toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  onChanged: (val) =>
                      setState(() => _defenseStat = val.round()),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text("Goalkeeping Stat", style: TextStyle(fontSize: 12.0)),
                Slider(
                  value: (_goalkeppingStat ?? 1).toDouble(),
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
                      final databaseReference = FirebaseFirestore.instance;
                      void createPlayer() async {
                        DocumentReference ref =
                            await databaseReference.collection("Players").add({
                          'uid': user.uid,
                          'name': _playerName,
                          'position': _playerPosition,
                          'attack': _attackStat,
                          'midfield': _midfieldStat,
                          'defense': _defenseStat,
                          'goalkeeping': _goalkeppingStat,
                          'isAvaliable': _isAvaliable,
                        });
                        print(ref.id);
                      }

                      createPlayer();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
