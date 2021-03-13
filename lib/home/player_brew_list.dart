import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/home/summary_page.dart';
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
            floatingActionButton: SizedBox(
              width: width * 0.9,
              height: height * 0.08,
              child: FlatButton(
                color: Color.fromRGBO(186, 15, 48, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                child: Text(
                  'View Avaliable Players',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SummaryPage()));
                },
              ),
            ),
            body: Container(
              child: ListView.builder(
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
                                        .doc(snapshot.data.docs[index])
                                        .delete();
                                  }),
                              FlatButton.icon(
                                  icon: Icon(Icons.settings),
                                  label: Text(''),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return Scaffold(
                                              resizeToAvoidBottomInset: true,
                                              resizeToAvoidBottomPadding: false,
                                              appBar: AppBar(
                                                backgroundColor: Color.fromRGBO(
                                                    186, 15, 48, 1),
                                                title: Text('UPDATE PLAYER'),
                                                centerTitle: false,
                                              ),
                                              body: SingleChildScrollView(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 20.0, right: 20.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      Text('Player Name: '),
                                                      SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      TextFormField(
                                                        textAlign:
                                                            TextAlign.center,
                                                        controller: _name,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                      20.0,
                                                                      15.0,
                                                                      20.0,
                                                                      15.0),
                                                          hintText:
                                                              'Player Name',
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              borderSide: BorderSide(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .black)),
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        controller: _position,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                      20.0,
                                                                      15.0,
                                                                      20.0,
                                                                      15.0),
                                                          hintText:
                                                              'Player Position',
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              borderSide: BorderSide(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .black)),
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly
                                                        ],
                                                        controller: _attack,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                      20.0,
                                                                      15.0,
                                                                      20.0,
                                                                      15.0),
                                                          hintText:
                                                              'Player Attack',
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              borderSide: BorderSide(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .black)),
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly
                                                        ],
                                                        controller: _midfield,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                      20.0,
                                                                      15.0,
                                                                      20.0,
                                                                      15.0),
                                                          hintText:
                                                              'Player Midfield',
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              borderSide: BorderSide(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .black)),
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
                                                        textAlign:
                                                            TextAlign.center,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly
                                                        ],
                                                        controller: _defense,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                      20.0,
                                                                      15.0,
                                                                      20.0,
                                                                      15.0),
                                                          hintText:
                                                              'Player Defense',
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              borderSide: BorderSide(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      Text(
                                                          'Player Goalkeeping: '),
                                                      SizedBox(
                                                        height: 10.0,
                                                      ),
                                                      TextFormField(
                                                        textAlign:
                                                            TextAlign.center,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .digitsOnly
                                                        ],
                                                        controller:
                                                            _goalkeeping,
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                      20.0,
                                                                      15.0,
                                                                      20.0,
                                                                      15.0),
                                                          hintText:
                                                              'Player Goalkeeping',
                                                          enabledBorder: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                              borderSide: BorderSide(
                                                                  width: 2,
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      Text(
                                                          'Player Avaliability: '),
                                                      Checkbox(
                                                          tristate: false,
                                                          activeColor:
                                                              Color.fromRGBO(
                                                                  186,
                                                                  15,
                                                                  48,
                                                                  1),
                                                          checkColor:
                                                              Colors.white,
                                                          value: _isAvaliable,
                                                          onChanged:
                                                              (bool value) {
                                                            setState(() {
                                                              _isAvaliable =
                                                                  value;
                                                            });
                                                          }),
                                                      Container(
                                                        width: width,
                                                        child: RaisedButton(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          18.0),
                                                            ),
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    50.0,
                                                                    15.0,
                                                                    50.0,
                                                                    15.0),
                                                            color:
                                                                Color.fromRGBO(
                                                                    186,
                                                                    15,
                                                                    48,
                                                                    1),
                                                            child: Text(
                                                              'Update',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 25,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            onPressed: () {
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Players')
                                                                  .doc(snapshot
                                                                          .data
                                                                          .docs[index]
                                                                      ['docId'])
                                                                  .update({
                                                                "name":
                                                                    _name.text,
                                                                "position":
                                                                    _position
                                                                        .text,
                                                                "attack": int
                                                                    .parse(_attack
                                                                        .text),
                                                                "midfield": int
                                                                    .parse(_attack
                                                                        .text),
                                                                "defense": int
                                                                    .parse(_attack
                                                                        .text),
                                                                "goalkeeping":
                                                                    int.parse(
                                                                        _attack
                                                                            .text),
                                                                "isAvaliable":
                                                                    _isAvaliable
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  })
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
