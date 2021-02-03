import 'package:flutter/material.dart';
import 'package:screens_ui/models/players.dart';
import 'package:screens_ui/services/auth.dart';
import 'package:screens_ui/services/databases_players.dart';
import 'package:provider/provider.dart';
import 'players_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Player>>.value(
      value: DatabaseService().players,
      child: Scaffold(
        backgroundColor: Colors.green[300],
        appBar: AppBar(
          title: Text('Retro FC Players'),
          backgroundColor: Colors.green[800],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: PlayerList(),
      ),
    );
  }
}
