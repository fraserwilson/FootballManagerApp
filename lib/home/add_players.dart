import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/models/user.dart';
import 'package:flutter/services.dart';

class AddPlayersFo extends StatefulWidget {
  @override
  _AddPlayersFoState createState() => _AddPlayersFoState();
}

class _AddPlayersFoState extends State<AddPlayersFo> {
  final _formKey = GlobalKey<FormState>();

  //form values
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
    final user = Provider.of<ConvertedUser>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(186, 15, 48, 1),
        title: Text('ADD PLAYERS'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: height * 0.03,
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
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Player Name',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black)),
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
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Player Position',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black)),
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
                    controller: _attack,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Player Attack',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black)),
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
                    controller: _midfield,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Player Midfield',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black)),
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
                    controller: _defense,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Player Defense',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black)),
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
                    controller: _goalkeeping,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Player Goalkeeping',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          borderSide:
                              BorderSide(width: 2, color: Colors.black)),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text('Player Avaliability: '),
                  Checkbox(
                      tristate: false,
                      activeColor: Color.fromRGBO(186, 15, 48, 1),
                      checkColor: Colors.white,
                      value: _isAvaliable,
                      onChanged: (bool value) {
                        setState(() {
                          _isAvaliable = value;
                        });
                      }),
                  Container(
                    width: width,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        padding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0),
                        color: Color.fromRGBO(186, 15, 48, 1),
                        child: Text(
                          'Add',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          final databaseReference = FirebaseFirestore.instance;
                          void createPlayer() async {
                            var ref =
                                databaseReference.collection('Players').doc();
                            await ref.set({
                              'uid': user.uid,
                              'name': _name.text,
                              'position': _position.text,
                              'attack': int.parse(_attack.text),
                              'midfield': int.parse(_midfield.text),
                              'defense': int.parse(_defense.text),
                              'goalkeeping': int.parse(_goalkeeping.text),
                              'isAvaliable': _isAvaliable,
                              'docId': ref.id
                            });
                            print(ref.id);
                          }

                          createPlayer();
                          Navigator.pop(context);
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
