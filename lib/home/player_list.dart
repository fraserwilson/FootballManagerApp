import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/home/player_brew_list.dart';
import 'package:screens_ui/home/player_details.dart';
import 'package:screens_ui/models/players.dart';
import 'package:screens_ui/shared/loading.dart';
import 'package:screens_ui/services/database_players.dart';

class PlayerList extends StatefulWidget {
  final PlayersModel playersModel;
  PlayerList({this.playersModel});
  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  Future _data;
  Future getPlayers() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection('Players')
        .where('uid', isEqualTo: firebaseUser.uid)
        .get();
    return qn.docs;
  }

  navigateToDetails(DocumentSnapshot detail) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  playerDetail: detail,
                )));
  }

  @override
  void initState() {
    super.initState();
    _data = getPlayers();
  }

  Widget build(BuildContext context) {
    return StreamProvider<List<PlayersModel>>.value(
      value: PlayerDatabaseService().players,
      child: Scaffold(
        body: PlayerBrewList(),
      ),
    );
  }
}
