import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  bool isAvaliable = true;
  Query query;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Summary Page'),
        ),
        body: Column(
          children: [
            Card(
              child: Text(query.toString()),
            ),
            FloatingActionButton(onPressed: () {
              query = FirebaseFirestore.instance
                  .collection('Players')
                  .where('isAvaliable', isEqualTo: isAvaliable);
            })
          ],
        ));
  }
}
