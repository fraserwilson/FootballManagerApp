import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  CalendarController _controller = CalendarController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('RESULTS'),
        centerTitle: true,
      ),
      body: Center(child: TableCalendar(calendarController: _controller, availableGestures: AvailableGestures.horizontalSwipe,),),
    );
  }
}

Future navigateToResultspage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => ResultsPage()));
}