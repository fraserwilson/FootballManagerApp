import 'package:flutter/material.dart';
import 'package:screens_ui/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListOfResults extends StatefulWidget {
  @override
  _ListOfResultsState createState() => _ListOfResultsState();
}

class _ListOfResultsState extends State<ListOfResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Results'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot docSnap = snapshot.data.docs[index];
                return Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Card(
                        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                        child: ListTile(
                            onTap: () {
                              //ToDo
                            },
                            leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25.0,
                                backgroundImage:
                                    AssetImage('assets/player.png')),
                            title: Text(docSnap['title']),
                            subtitle: Text(
                                'Position: ${docSnap['date'].toString()}'))));
              },
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
