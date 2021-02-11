import 'package:flutter/material.dart';
import 'package:screens_ui/home/add_players.dart';

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
        title: Text('Squad Players'),
        actions: [
          FlatButton.icon(
              onPressed: () => _showAddPlayer(),
              icon: Icon(Icons.add),
              label: Text('Add Players'))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[Text('Players to be presented here')],
        ),
      ),
    );
  }
}
