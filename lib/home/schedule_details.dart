import 'package:flutter/material.dart';

class ScheduleDetails extends StatefulWidget {
  final String date;
  final String title;
  final String description;
  final String userId;
  ScheduleDetails({
    this.title,
    this.description,
    this.date,
    this.userId,
  });
  @override
  _ScheduleDetailsState createState() => _ScheduleDetailsState();
}

class _ScheduleDetailsState extends State<ScheduleDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(186, 15, 48, 1),
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
          ListTile(
            title: Text(
              widget.title ?? 'Test Title',
              style: Theme.of(context).textTheme.headline5,
            ),
            subtitle: Text(widget.date ?? 'Test Date'),
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
