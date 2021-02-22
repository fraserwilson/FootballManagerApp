import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:date_time_picker/date_time_picker.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarController _calendarController = CalendarController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SCHEDULE'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.all(8.0),
              child: TableCalendar(
                calendarController: _calendarController,
                calendarStyle: CalendarStyle(),
                builders: CalendarBuilders(),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEventPage(
                        selectedDate: _calendarController.selectedDay,
                      )));
        },
      ),
    );
  }
}

Future navigateToSchedulepage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SchedulePage()));
}

class AddEventPage extends StatefulWidget {
  final DateTime selectedDate;
  AddEventPage({this.selectedDate});
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  DateTime pickedDate;
  TimeOfDay time;
  @override
  void initState() {
    super.initState();
    pickedDate = widget.selectedDate ?? DateTime.now();
    time = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    _pickDate() async {
      DateTime date = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDate: pickedDate,
      );
      if (date != null)
        setState(() {
          pickedDate = date;
        });
    }

    _pickTime() async {
      TimeOfDay t = await showTimePicker(context: context, initialTime: time);
      if (t != null)
        setState(() {
          time = t;
        });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [ElevatedButton(onPressed: () async {}, child: Text('Save'))],
      ),
      body: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Add Title',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 48.0)),
                ),
                Divider(),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Add Description',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.short_text),
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text(
                      "Date: ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: _pickDate,
                ),
                ListTile(
                  title: Text("Time: ${time.hour}:${time.minute}"),
                  trailing: Icon(Icons.keyboard_arrow_down),
                  onTap: _pickTime,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
