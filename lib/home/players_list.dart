import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/models/players.dart';
import 'package:screens_ui/home/player_tile.dart';

class PlayerList extends StatefulWidget {
  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  @override
  Widget build(BuildContext context) {
    final players = Provider.of<List<Player>>(context);

    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        return PlayerTile(player: players[index]);
      },
    );
  }
}
