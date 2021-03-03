import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  CalendarController _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results of Games'),
        centerTitle: true,
      ),
    );
  }
}
