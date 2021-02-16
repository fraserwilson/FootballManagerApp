import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/home/player_brew_tile.dart';
import 'package:screens_ui/models/players.dart';

class PlayerBrewList extends StatefulWidget {
  @override
  _PlayerBrewListState createState() => _PlayerBrewListState();
}

class _PlayerBrewListState extends State<PlayerBrewList> {
  @override
  Widget build(BuildContext context) {
    final players = Provider.of<List<PlayersModel>>(context);
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        return PlayerBrewTile(player: players[index]);
      },
    );
  }
}
