import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarController _controller;
  TextEditingController _eventController;
  SharedPreferences prefs;
  List<dynamic> _selectedEvents;
  String dropdownValue = 'Games';
  String holder = '';
  Map<DateTime, List<dynamic>> _events;

  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _selectedEvents = [];
    _events = {};
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Games'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
                events: _events,
                calendarStyle: CalendarStyle(
                    todayColor: Colors.blue,
                    selectedColor: Theme.of(context).primaryColor,
                    todayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white)),
                headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonDecoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    formatButtonTextStyle: TextStyle(color: Colors.white),
                    formatButtonShowsNext: false),
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: (day, events, holidays) {
                  setState(() {
                    _selectedEvents = events;
                  });
                },
                calendarController: _controller),
            ..._selectedEvents.map((event) => ListTile(
                  title: Text(event),
                  /*trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      prefs.clear();
                    },
                  ),*/
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddDialog();
        },
      ),
    );
  }

  _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Game Day VS'),
        content: TextField(
          controller: _eventController,
          decoration: InputDecoration(hintText: 'Opponent Name'),
        ),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                if (_eventController.text.isEmpty) return;
                setState(() {
                  if (_events[_controller.selectedDay] != null) {
                    _events[_controller.selectedDay].add(_eventController.text);
                  } else {
                    _events[_controller.selectedDay] = [_eventController.text];
                  }
                  prefs.setString("events", json.encode(encodeMap(_events)));
                  _eventController.clear();
                  Navigator.pop(context);
                });
              },
              child: Text('Save'))
        ],
      ),
    );
  }
}
