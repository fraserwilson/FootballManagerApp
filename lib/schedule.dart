import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarController _controller = CalendarController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('SCHEDULE'),
        centerTitle: true,
      ),
      body: Center(child: TableCalendar(calendarController: _controller, availableGestures: AvailableGestures.horizontalSwipe,),),
    );
  }
}

Future navigateToSchedulepage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => SchedulePage()));
}