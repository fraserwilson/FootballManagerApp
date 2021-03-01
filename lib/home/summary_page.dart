import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:screens_ui/home/view_pdf.dart';
import 'package:screens_ui/shared/loading.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  int _currentIndex = 0;
  bool isAvaliable = true;
  Query query;
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
                    'This is the second heading hich will showcase my squad formation and squad playstyle'),
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
              content: Padding(
                padding: EdgeInsets.all(8.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25.0,
                              backgroundImage:
                                  AssetImage('assets/running.jpg')),
                          title: Text('Counter-Attack'),
                          subtitle: Text('Fast, reactive free-flowing play'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25.0,
                              backgroundImage:
                                  AssetImage('assets/passing.png')),
                          title: Text('Tiki-Taka'),
                          subtitle: Text(
                              'Short passes, with the intent to break down opposition teams'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25.0,
                              backgroundImage:
                                  AssetImage('assets/crossing.png')),
                          title: Text('Long balls'),
                          subtitle: Text(
                              'Constant crosses into the box, generally after absorbing large amounts of pressure'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
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
              content: Padding(
                padding: EdgeInsets.all(8.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25.0,
                              backgroundImage: AssetImage('assets/442.jpg')),
                          title: Text('4-4-2'),
                          subtitle:
                              Text('4 defenders, 4 midfielders, 2 forwards'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25.0,
                              backgroundImage: AssetImage('assets/433.jpg')),
                          title: Text('4-3-3'),
                          subtitle:
                              Text('4 defenders, 3 midfielders, 3 forwards'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 25.0,
                              backgroundImage: AssetImage('assets/352.png')),
                          title: Text('3-5-2'),
                          subtitle:
                              Text('3 defenders, 5 midfielders, 2 forwards'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Summary Page'),
        actions: [
          FlatButton.icon(
              onPressed: () async {
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
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Playstyle'),
          BottomNavigationBarItem(
              icon: Icon(Icons.time_to_leave), label: 'Formation'),
        ],
      ),
    );
  }
}
