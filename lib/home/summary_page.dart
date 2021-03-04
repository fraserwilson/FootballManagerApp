import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screens_ui/home/results.dart';
import 'package:screens_ui/home/schedule.dart';
import 'package:screens_ui/home/view_pdf.dart';
import 'package:screens_ui/shared/loading.dart';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  int _currentIndex = 0;
  bool isAvaliable = true;
  Query query;
  bool counterAttack = false;
  bool tikiTaka = false;
  bool longBalls = false;
  bool fourFourTwo = false;
  bool fourThreeThree = false;
  bool threeFiveTwo = false;
  static GlobalKey previewContainer = new GlobalKey();
  final pdf = pw.Document();

  writeOnPdf() {
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Header(level: 0, child: pw.Text('Squad List')),
            pw.Paragraph(text: 'This will showcase my squad list'),
            pw.Header(level: 1, child: pw.Text('Second Heading')),
            pw.Paragraph(
                text:
                    'This is the second heading which will showcase my squad formation and squad playstyle'),
          ];
        },
      ),
    );
  }

  Future savePdf() async {
    Directory docmuentDirectory = await getApplicationDocumentsDirectory();

    String path = docmuentDirectory.path;

    File file = File("$path/example.pdf");
    file.writeAsBytesSync(pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
      if (index == 0) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                scrollable: true,
                title: Text('Playstyles'),
                content: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: ListTile(
                              tileColor:
                                  counterAttack ? Colors.blue : Colors.white,
                              leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25.0,
                                  backgroundImage:
                                      AssetImage('assets/running.jpg')),
                              title: Text('Counter-Attack'),
                              subtitle:
                                  Text('Fast, reactive free-flowing play'),
                              onTap: () {
                                setState(() {
                                  counterAttack = !counterAttack;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: ListTile(
                              tileColor: tikiTaka ? Colors.blue : Colors.white,
                              leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25.0,
                                  backgroundImage:
                                      AssetImage('assets/passing.png')),
                              title: Text('Tiki-Taka'),
                              subtitle: Text(
                                  'Short passes, with the intent to break down opposition teams'),
                              onTap: () {
                                setState(() {
                                  tikiTaka = !tikiTaka;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: ListTile(
                              tileColor: longBalls ? Colors.blue : Colors.white,
                              leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25.0,
                                  backgroundImage:
                                      AssetImage('assets/crossing.png')),
                              title: Text('Long balls'),
                              subtitle: Text(
                                  'Constant crosses into the box, generally after absorbing large amounts of pressure'),
                              onTap: () {
                                setState(() {
                                  longBalls = !longBalls;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }));
          },
        );
      }
      if (index == 1) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              scrollable: true,
              title: Text('Team Formations'),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: ListTile(
                              tileColor:
                                  fourFourTwo ? Colors.blue : Colors.white,
                              leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25.0,
                                  backgroundImage:
                                      AssetImage('assets/442.jpg')),
                              title: Text('4-4-2'),
                              subtitle: Text(
                                  '4 defenders, 4 midfielders, 2 forwards'),
                              onTap: () {
                                setState(() {
                                  fourFourTwo = !fourFourTwo;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: ListTile(
                              tileColor:
                                  fourThreeThree ? Colors.blue : Colors.white,
                              leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25.0,
                                  backgroundImage:
                                      AssetImage('assets/433.jpg')),
                              title: Text('4-3-3'),
                              subtitle: Text(
                                  '4 defenders, 3 midfielders, 3 forwards'),
                              onTap: () {
                                setState(() {
                                  fourThreeThree = !fourThreeThree;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: ListTile(
                              tileColor:
                                  threeFiveTwo ? Colors.blue : Colors.white,
                              leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25.0,
                                  backgroundImage:
                                      AssetImage('assets/352.png')),
                              title: Text('3-5-2'),
                              subtitle: Text(
                                  '3 defenders, 5 midfielders, 2 forwards'),
                              onTap: () {
                                setState(() {
                                  threeFiveTwo = !threeFiveTwo;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      }
      if (index == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SchedulePage()));
      }
      if (index == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResultsPage()));
      }
    }

    return RepaintBoundary(
      key: previewContainer,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Summary Page'),
          actions: [
            FlatButton.icon(
                onPressed: () async {
                  // takeScreenShot() async {
                  //   RenderRepaintBoundary boundary =
                  //       previewContainer.currentContext.findRenderObject();
                  //   ui.Image image = await boundary.toImage();
                  //   final directory =
                  //       (await getApplicationDocumentsDirectory()).path;
                  //   ByteData byteData =
                  //       await image.toByteData(format: ui.ImageByteFormat.png);
                  //   Uint8List pngBytes = byteData.buffer.asUint8List();
                  //   print(pngBytes);
                  //   File imgFile = new File('$directory/screenshot.png');
                  //   imgFile.writeAsBytes(pngBytes);
                  // }

                  // takeScreenShot();
                  writeOnPdf();
                  await savePdf();
                  Directory docmuentDirectory =
                      await getApplicationDocumentsDirectory();

                  String path = docmuentDirectory.path;
                  String fullPath = "$path/example.pdf";
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PDFPreview(path: fullPath)));
                },
                icon: Icon(
                  Icons.mail,
                  color: Colors.white,
                ),
                label: Text(
                  'Save Squad',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Players')
              .where('isAvaliable', isEqualTo: isAvaliable)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot docSnap = snapshot.data.docs[index];
                  return Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Card(
                          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                          child: ListTile(
                              onTap: () {
                                //ToDo
                              },
                              leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 25.0,
                                  backgroundImage:
                                      AssetImage('assets/player.png')),
                              title: Text(docSnap['name']),
                              subtitle:
                                  Text('Position: ${docSnap['position']}'))));
                },
              );
            } else {
              return Loading();
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Playstyle'),
            BottomNavigationBarItem(
                icon: Icon(Icons.time_to_leave), label: 'Formation'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: 'Schedule'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_view_day), label: 'Results'),
          ],
        ),
      ),
    );
  }
}
