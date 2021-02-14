import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:screens_ui/models/players.dart';

class DetailPage extends StatefulWidget {
  final DocumentSnapshot playerDetail;
  DetailPage({this.playerDetail});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playerDetail.data()['name']),
      ),
      body: Container(
        child: Card(
          child: ListTile(
            title: Text(
              widget.playerDetail.data()['name'],
              textAlign: TextAlign.center,
            ),
            subtitle: Column(
              children: [
                Text('Attack: ' +
                    widget.playerDetail.data()['attack'].toString()),
                Text('Midfield: ' +
                    widget.playerDetail.data()['midfield'].toString()),
                Text('Defense: ' +
                    widget.playerDetail.data()['defense'].toString()),
                Text('Goalkeeping: ' +
                    widget.playerDetail.data()['goalkeeping'].toString()),
                Text('Is player avaliable? ' +
                    widget.playerDetail.data()['isAvaliable'].toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
