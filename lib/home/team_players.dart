import 'package:flutter/material.dart';

class TeamPlayers extends StatefulWidget {
  @override
  _TeamPlayersState createState() => _TeamPlayersState();
}

class _TeamPlayersState extends State<TeamPlayers> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Squad Players'),
        actions: [
          FlatButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text('Add Players'))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
