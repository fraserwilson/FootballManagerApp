import 'package:flutter/material.dart';
import 'package:screens_ui/models/app_event.dart';
import 'package:screens_ui/services/event_firestore_services.dart';
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
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot docSnap = snapshot.data.docs[index];
                return ListTile(
                  title: Text(docSnap['title']),
                );
              },
            );
          }),
    );
  }
}
