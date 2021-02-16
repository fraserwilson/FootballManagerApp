import 'package:flutter/material.dart';
import 'package:screens_ui/models/players.dart';

class PlayerBrewTile extends StatelessWidget {
  final PlayersModel player;
  PlayerBrewTile({this.player});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25.0,
              backgroundImage: AssetImage('assets/player.png')),
          title: Text(player.name),
          subtitle: Text('Position: ${player.position}'),
        ),
      ),
    );
  }
}
