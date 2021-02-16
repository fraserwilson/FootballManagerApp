import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/home/player_details.dart';
import 'package:screens_ui/models/players.dart';
import 'package:screens_ui/shared/loading.dart';

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
    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: _data,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("Loading"),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.asset('assets/player.png'),
                        title: Text(
                          snapshot.data[index].data()['name'],
                        ),
                        subtitle: Text(snapshot.data[index].data()['position']),
                        onTap: () => navigateToDetails(snapshot.data[index]),
                        trailing: SingleChildScrollView(
                          child: Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  print(snapshot.data[index].id);
                                  FirebaseFirestore.instance
                                      .collection('Players')
                                      .doc(snapshot.data[index].id)
                                      .delete();
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.colorize_sharp),
                                onPressed: () {
                                  print(snapshot.data[index].id);
                                  FirebaseFirestore.instance
                                      .collection('Players')
                                      .doc(snapshot.data[index].id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}
