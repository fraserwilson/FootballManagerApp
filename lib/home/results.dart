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
    return Scaffold(
      appBar: AppBar(
        title: Text('Results of Games'),
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
                calendarController: _controller,
                headerStyle: HeaderStyle(
                  decoration: BoxDecoration(color: Colors.blue),
                  headerMargin: EdgeInsets.only(bottom: 8.0),
                  titleTextStyle: TextStyle(color: Colors.white),
                  formatButtonDecoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  formatButtonTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                  ),
                ),
                calendarStyle: CalendarStyle(),
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
                                          child: Text('Delete'),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddEvent(
                        selectedDate: _controller.selectedDay,
                      )));
        },
      ),
    );
  }
}
