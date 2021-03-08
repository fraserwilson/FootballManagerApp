import 'package:flutter/material.dart';
import 'package:screens_ui/services/event_firestore_services.dart';
import 'package:screens_ui/models/app_event.dart';

class EventDetails extends StatefulWidget {
  final String date;
  final String title;
  final String description;
  final String userId;
  final String yourTeamScore;
  final String enemyTeamScore;
  EventDetails(
      {this.title,
      this.description,
      this.date,
      this.userId,
      this.yourTeamScore,
      this.enemyTeamScore});
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text(widget.date ?? 'Test Date'),
          ListTile(
            title: Text(
              widget.title ?? 'Test Title',
              style: Theme.of(context).textTheme.headline5,
            ),
            subtitle: Row(
              children: [
                Text('Team Score: '),
                Text(widget.yourTeamScore ?? 'Your Team Score - '),
                Text(' - '),
                Text(widget.enemyTeamScore ?? 'Enemy Team Score'),
                Text(' :Enemy Score'),
              ],
            ),
          ),
          SizedBox(height: 10),
          if (widget.description != null)
            ListTile(
              title: Text(widget.description ?? 'Test description'),
            ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
