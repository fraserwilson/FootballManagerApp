import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/home/home.dart';
import 'package:screens_ui/home/summary_page.dart';
import 'package:screens_ui/home/player_details.dart';
import 'package:screens_ui/models/players.dart';

class PlayerBrewList extends StatefulWidget {
  @override
  _PlayerBrewListState createState() => _PlayerBrewListState();
}

class _PlayerBrewListState extends State<PlayerBrewList> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _position = new TextEditingController();
  TextEditingController _attack = new TextEditingController();
  TextEditingController _midfield = new TextEditingController();
  TextEditingController _defense = new TextEditingController();
  TextEditingController _goalkeeping = new TextEditingController();
  bool _isAvaliable = false;
  @override
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
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.confirmation_num),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SummaryPage()));
              },
            ),
            body: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                    child: ListTile(
                      onTap: () {
                        //ToDo
                      },
                      leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 25.0,
                          backgroundImage: AssetImage('assets/player.png')),
                      title: Text(snapshot.data.docs[index]['name']),
                      subtitle: Text(
                          'Position: ${snapshot.data.docs[index]['position']}'),
                      trailing: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            FlatButton.icon(
                                icon: Icon(Icons.delete),
                                label: Text(''),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('Players')
                                      .doc(snapshot.data.docs[index]['docId'])
                                      .delete();
                                }),
                            FlatButton.icon(
                              icon: Icon(Icons.settings),
                              label: Text(''),
                              onPressed: () {
                                print(snapshot.data.docs[index]['docId']);
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return Scaffold(
                                      resizeToAvoidBottomInset: true,
                                      resizeToAvoidBottomPadding: false,
                                      appBar: AppBar(
                                        title: Text('UPDATE PLAYER'),
                                        centerTitle: true,
                                      ),
                                      body: SingleChildScrollView(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 20.0, right: 20.0),
                                          child: Column(
                                            children: <Widget>[
                                              Text(snapshot.data.docs[index]
                                                  ['docId']),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Text('Player Name: '),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              TextFormField(
                                                textAlign: TextAlign.center,
                                                controller: _name,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(20.0,
                                                          15.0, 20.0, 15.0),
                                                  hintText: 'Player Name',
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              70.0)),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Text('Player Position: '),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              TextFormField(
                                                textAlign: TextAlign.center,
                                                controller: _position,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(20.0,
                                                          15.0, 20.0, 15.0),
                                                  hintText: 'Player Position',
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              70.0)),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Text('Player Attack: '),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              TextFormField(
                                                textAlign: TextAlign.center,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                controller: _attack,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(20.0,
                                                          15.0, 20.0, 15.0),
                                                  hintText: 'Player Attack',
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              70.0)),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Text('Player Midfield: '),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              TextFormField(
                                                textAlign: TextAlign.center,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                controller: _midfield,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(20.0,
                                                          15.0, 20.0, 15.0),
                                                  hintText: 'Player Midfield',
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              70.0)),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Text('Player Defense: '),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              TextFormField(
                                                textAlign: TextAlign.center,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                controller: _defense,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(20.0,
                                                          15.0, 20.0, 15.0),
                                                  hintText: 'Player Defense',
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              70.0)),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Text('Player Goalkeeping: '),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              TextFormField(
                                                textAlign: TextAlign.center,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                controller: _goalkeeping,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(20.0,
                                                          15.0, 20.0, 15.0),
                                                  hintText:
                                                      'Player Goalkeeping',
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              70.0)),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              Text('Player Avaliability: '),
                                              Checkbox(
                                                  tristate: false,
                                                  value: _isAvaliable,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _isAvaliable = value;
                                                    });
                                                  }),
                                              RaisedButton(
                                                  color: Colors.blue,
                                                  child: Text(
                                                    'UPDATE',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('Players')
                                                        .doc(snapshot.data
                                                                .docs[index]
                                                            ['docId'])
                                                        .update({
                                                      "name": _name.text,
                                                      "position":
                                                          _position.text,
                                                      "attack": int.parse(
                                                          _attack.text),
                                                      "midfield": int.parse(
                                                          _attack.text),
                                                      "defense": int.parse(
                                                          _attack.text),
                                                      "goalkeeping": int.parse(
                                                          _attack.text),
                                                      //"isAvaliable": _isAvaliable
                                                    });
                                                    Navigator.pop(context);
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
