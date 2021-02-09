import 'package:cloud_firestore/cloud_firestore.dart';
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
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: db.collection("Managers").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var doc = snapshot.data.docs;
              return ListView.builder(
                  itemCount: doc.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PlayersList(doc[index].id)),
                          );
                        },
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              Text(doc[index].data()['email']),
                              SizedBox(
                                height: 10.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return LinearProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class PlayersList extends StatefulWidget {
  final doc;
  PlayersList(this.doc);
  @override
  _PlayersListState createState() => _PlayersListState();
}

class _PlayersListState extends State<PlayersList> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    void _showEditPlayerPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Text('Bottom Sheet'),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Player"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.settings),
            label: Text('Edit Player'),
            onPressed: () => _showEditPlayerPanel(),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection('Managers')
            .doc(widget.doc)
            .collection('Players')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var doc = snapshot.data.docs;
            return new ListView.builder(
                itemCount: doc.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25.0,
                          backgroundImage: AssetImage('assets/soccerball.jpg'),
                        ),
                        title: Text(doc[index].data()['name'] ?? 'Player name'),
                        subtitle: Text('Player position: ' +
                                doc[index].data()['postion'] ??
                            'Player position'),
                      ),
                    ),
                  );
                });
          } else {
            return LinearProgressIndicator();
          }
        },
      ),
    );
  }
}
