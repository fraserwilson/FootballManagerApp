import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:screens_ui/home/add_players.dart';
import 'package:screens_ui/home/player_list.dart';
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

    return Scaffold(
        appBar: AppBar(
          actions: [
            FlatButton.icon(
                onPressed: () => _showAddPlayer(),
                icon: Icon(Icons.add),
                label: Text('Add Players')),
          ],
        ),
        body: PlayerList());
  }
}
