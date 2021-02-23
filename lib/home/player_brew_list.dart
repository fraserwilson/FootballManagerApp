import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/models/players.dart';

class PlayerBrewList extends StatefulWidget {
  @override
  _PlayerBrewListState createState() => _PlayerBrewListState();
}

class _PlayerBrewListState extends State<PlayerBrewList> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _position = new TextEditingController();
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
                        backgroundImage: AssetImage('assets/player.png')),
                    title: Text(snapshot.data.docs[index]['name']),
                    subtitle:
                        Text('DocId: ${snapshot.data.docs[index]['docId']}'),
                    trailing: FlatButton.icon(
                      icon: Icon(Icons.settings),
                      label: Text('Edit Players'),
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
                                  margin:
                                      EdgeInsets.only(left: 20.0, right: 20.0),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: _name,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 15.0, 20.0, 15.0),
                                          hintText: 'Player Name',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(70.0)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: _position,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 15.0, 20.0, 15.0),
                                          hintText: 'Player Position',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(70.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
