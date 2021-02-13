import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:screens_ui/home/add_players.dart';
import 'package:screens_ui/models/players.dart';

class TeamPlayers extends StatefulWidget {
  @override
  _TeamPlayersState createState() => _TeamPlayersState();
}

class _TeamPlayersState extends State<TeamPlayers> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void _showAddPlayer() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 60.0),
              child: AddPlayersFo(),
            );
          });
    }

    final databaseReference = FirebaseFirestore.instance;
    void getData() {
      databaseReference
          .collection("Players")
          .get()
          .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((f) => print(f.data()));
      });
    }

    void updateData() {
      try {
        databaseReference
            .collection('Players')
            .doc('i80TtaJmfzNJ9ksaYuZB')
            .update({'name': 'Roshi'});
      } catch (e) {
        print(e.toString());
      }
    }

    void deleteData() {
      try {
        databaseReference
            .collection('Players')
            .doc('i80TtaJmfzNJ9ksaYuZB')
            .delete();
      } catch (e) {
        print(e.toString());
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton.icon(
              onPressed: () => _showAddPlayer(),
              icon: Icon(Icons.add),
              label: Text('Add Players')),
          FlatButton.icon(
              onPressed: () => getData(),
              icon: Icon(Icons.add),
              label: Text('Current squad'))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                updateData();
              },
              child: Text('Update Player'),
            ),
            RaisedButton(
              onPressed: () {
                deleteData();
              },
              child: Text('Delete Player'),
            )
          ],
        ),
      ),
    );
  }
}
