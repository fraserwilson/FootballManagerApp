import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/home/player_brew_tile.dart';
import 'package:screens_ui/models/players.dart';
import 'package:screens_ui/models/user.dart';
import 'package:screens_ui/services/database_players.dart';
import 'package:screens_ui/shared/loading.dart';

class PlayerBrewList extends StatefulWidget {
  final PlayersModel player;
  PlayerBrewList({this.player});
  @override
  _PlayerBrewListState createState() => _PlayerBrewListState();
}

class _PlayerBrewListState extends State<PlayerBrewList> {
  final _formKey = GlobalKey<FormState>();
  String _playerName;
  String _playerPosition;
  int _attackStat = 1;
  int _midfieldStat = 1;
  int _defenseStat = 1;
  int _goalkeppingStat = 1;
  bool _isAvaliable = false;
  Widget build(BuildContext context) {
    final players = Provider.of<List<PlayersModel>>(context) ?? [];
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('Players').get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("Loading"),
            );
          } else {
            return ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Card(
                        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                        child: ListTile(
                            leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25.0,
                                backgroundImage:
                                    AssetImage('assets/player.png')),
                            title: Text(snapshot.data.docs[index]['name']),
                            subtitle: Text(
                                'DocId: ${snapshot.data.docs[index]['docId']}'),
                            trailing: FlatButton.icon(
                                icon: Icon(Icons.settings),
                                label: Text('Edit Players'),
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 60.0,
                                                horizontal: 60.0),
                                            child: SingleChildScrollView(
                                                child: Form(
                                                    key: _formKey,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Text("Edit Player",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    18.0)),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        TextFormField(
                                                          initialValue: snapshot
                                                                  .data
                                                                  .docs[index]
                                                              ['name'],
                                                          decoration:
                                                              InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                          )),
                                                          validator: (val) => val
                                                                  .isEmpty
                                                              ? 'Please enter a name'
                                                              : null,
                                                          onChanged: (val) =>
                                                              setState(() =>
                                                                  _playerName =
                                                                      val),
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        TextFormField(
                                                          initialValue: snapshot
                                                                  .data
                                                                  .docs[index]
                                                              ['position'],
                                                          decoration:
                                                              InputDecoration(
                                                                  border:
                                                                      OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                          )),
                                                          validator: (val) => val
                                                                  .isEmpty
                                                              ? 'Please enter a position'
                                                              : null,
                                                          onChanged: (val) =>
                                                              setState(() =>
                                                                  _playerPosition =
                                                                      val),
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text("Attack Stat",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    12.0)),
                                                        Slider(
                                                          value: (_attackStat ??
                                                                  snapshot.data
                                                                              .docs[
                                                                          index]
                                                                      [
                                                                      'attack'])
                                                              .toDouble(),
                                                          min: 1,
                                                          max: 10,
                                                          divisions: 9,
                                                          onChanged: (val) =>
                                                              setState(() =>
                                                                  _attackStat =
                                                                      val.round()),
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text("Midfield Stat",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    12.0)),
                                                        Slider(
                                                          value: (_midfieldStat ??
                                                                  snapshot.data
                                                                              .docs[
                                                                          index]
                                                                      [
                                                                      'midfield'])
                                                              .toDouble(),
                                                          min: 1,
                                                          max: 10,
                                                          divisions: 9,
                                                          onChanged: (val) =>
                                                              setState(() =>
                                                                  _midfieldStat =
                                                                      val.round()),
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text("Defense Stat",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    12.0)),
                                                        Slider(
                                                          value: (_defenseStat ??
                                                                  snapshot.data
                                                                              .docs[
                                                                          index]
                                                                      [
                                                                      'defense'])
                                                              .toDouble(),
                                                          min: 1,
                                                          max: 10,
                                                          divisions: 9,
                                                          onChanged: (val) =>
                                                              setState(() =>
                                                                  _defenseStat =
                                                                      val.round()),
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text("Goalkeeping Stat",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    12.0)),
                                                        Slider(
                                                          value: (_goalkeppingStat ??
                                                                  snapshot.data
                                                                              .docs[
                                                                          index]
                                                                      [
                                                                      'goalkepping'])
                                                              .toDouble(),
                                                          min: 1,
                                                          max: 10,
                                                          divisions: 9,
                                                          onChanged: (val) =>
                                                              setState(() =>
                                                                  _goalkeppingStat =
                                                                      val.round()),
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text(
                                                            'Is this player avaliable?'),
                                                        Checkbox(
                                                            tristate: false,
                                                            value: _isAvaliable ??
                                                                snapshot.data
                                                                            .docs[
                                                                        index][
                                                                    'isAvaliable'],
                                                            onChanged:
                                                                (bool value) {
                                                              setState(() {
                                                                _isAvaliable =
                                                                    value;
                                                              });
                                                            }),
                                                        RaisedButton(
                                                            color: Colors.blue,
                                                            child: Text(
                                                              'Edit',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onPressed: () {
                                                              if (_formKey
                                                                  .currentState
                                                                  .validate()) {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Players')
                                                                    .doc(snapshot
                                                                        .data[
                                                                            index]
                                                                        .docId)
                                                                    .set({
                                                                  'name': _playerName ??
                                                                      snapshot
                                                                          .data
                                                                          .name,
                                                                  'position': _playerPosition ??
                                                                      snapshot
                                                                          .data
                                                                          .position,
                                                                  'attack': _attackStat ??
                                                                      snapshot
                                                                          .data
                                                                          .attack,
                                                                  'midfield': _midfieldStat ??
                                                                      snapshot
                                                                          .data
                                                                          .midfield,
                                                                  'defense': _defenseStat ??
                                                                      snapshot
                                                                          .data
                                                                          .defense,
                                                                  'goalkeeping':
                                                                      _goalkeppingStat ??
                                                                          snapshot
                                                                              .data
                                                                              .goalkeeping,
                                                                  'isAvaliable':
                                                                      _isAvaliable ??
                                                                          snapshot
                                                                              .data
                                                                              .isAvaliable
                                                                });

                                                                Navigator.pop(
                                                                    context);
                                                              }
                                                            })
                                                      ],
                                                    ))));
                                      });
                                }))));
              },
            );
          }
        });
  }
}
