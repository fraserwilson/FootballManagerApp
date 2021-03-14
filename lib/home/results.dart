import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter/material.dart';
import 'package:screens_ui/home/add_events.dart';
import 'package:screens_ui/models/app_event.dart';
import 'package:screens_ui/services/event_firestore_services.dart';
import 'package:screens_ui/shared/loading.dart';
import 'package:table_calendar/table_calendar.dart';
import 'list_of_results.dart';
import 'package:screens_ui/home/event_details.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  CalendarController _controller = CalendarController();

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(186, 15, 48, 1),
        title: Text('Results of Games'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.all(8.0),
              child: TableCalendar(
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Colors.black),
                    weekendStyle:
                        TextStyle(color: Color.fromRGBO(186, 15, 48, 1))),
                initialCalendarFormat: CalendarFormat.week,
                calendarController: _controller,
                headerStyle: HeaderStyle(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(186, 15, 48, 1)),
                  headerMargin: EdgeInsets.only(bottom: 8.0),
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  formatButtonDecoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  formatButtonTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  formatButtonShowsNext: false,
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
                calendarStyle: CalendarStyle(
                    todayColor: Colors.black,
                    todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    selectedColor: Color.fromRGBO(186, 15, 48, 1)),
                builders: CalendarBuilders(),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('events')
                    .where('userId',
                        isEqualTo: FirebaseAuth.instance.currentUser.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot docSnap = snapshot.data.docs[index];
                      Timestamp t = docSnap['date'];
                      DateTime d = DateTime.parse(t.toDate().toString());
                      String formattedDate = "${d.day}/${d.month}/${d.year}";
                      return ListTile(
                          title: Text(docSnap['title']),
                          subtitle: Text(formattedDate),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventDetails(
                                  title: docSnap['title'],
                                  description: docSnap['description'],
                                  date: formattedDate,
                                  userId: docSnap['userId'],
                                  yourTeamScore: docSnap['yourTeamScore'],
                                  enemyTeamScore: docSnap['enemyTeamScore'],
                                ),
                              ),
                            );
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.black,
                            onPressed: () async {
                              final confirm = await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Warning!'),
                                      content: Text(
                                          'Are you sure you want to delete?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    186, 15, 48, 1)),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                color: Colors.grey.shade700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) ??
                                  false;
                              if (confirm) {
                                FirebaseFirestore.instance
                                    .collection('events')
                                    .doc(docSnap.id)
                                    .delete();
                              }
                            },
                          ));
                    },
                  );
                }),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
            left: width * 0.03, right: width * 0.03, bottom: height * 0.01),
        width: width,
        child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            padding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0),
            color: Color.fromRGBO(186, 15, 48, 1),
            child: Text(
              'Add Result',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddEvent(
                            selectedDate: _controller.selectedDay,
                          )));
            }),
      ),
    );
  }
}
