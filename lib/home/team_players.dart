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
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[Text('Players will be listed here')],
        ),
      ),
    );
  }
}
