import 'dart:io';
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
            pw.Header(level: 0, child: pw.Text('Training Drill PDF')),
            pw.Header(level: 1, child: pw.Text('Counter Attacking Playstyle')),
            pw.Paragraph(
                text:
                    'If a counter attacking style of play is what you wish to select, then the following drills should be performed in order to best perform to your expectations:'),
            pw.Header(level: 3, child: pw.Text('Organization')),
            pw.Paragraph(
                text:
                    'Play in a total area of 20 X 30 yards - two areas of 20 x 15 yards'),
            pw.Header(level: 3, child: pw.Text('Activity')),
            pw.Paragraph(
                text:
                    'Play starts with a 4 v. 2 possession game. When the two inside players win the ball, they play 2 v. 2 in the other half, to try and score. Should the two defenders (Blue) win the ball, they quickly play the ball back to the original grid, and the two original defenders return back to the grid to defend.'),
            pw.Header(level: 3, child: pw.Text('Variations')),
            pw.Paragraph(text: 'Limit touches to attacking team'),
            pw.Paragraph(
                text:
                    'If waiting defenders (Blue) allows a goal, they become defenders in the first zone'),
            pw.Header(level: 3, child: pw.Text('Coaching Points')),
            pw.Paragraph(
                text:
                    'Possession team (Red) maintain possession of the ball by offering good support'),
            pw.Paragraph(
                text:
                    'Defending team (Black) defend as unit. Limit penetrating passes. Once the ball is won, transition quickly try to score'),
            pw.Header(level: 1, child: pw.Text('Tiki-Taka Playstyle')),
            pw.Paragraph(
                text:
                    'If a tiki-taka style of play is what you wish to select, then the following drills should be performed in order to best perform to your expectations:'),
            pw.Header(level: 3, child: pw.Text('Organization')),
            pw.Paragraph(
                text:
                    'Set up a playing area of 25x20yrds. The playing area is split into 3 zones. The central zone ion only 2 yards wide. There are 3 teams of 4 players. The defending team has 2 players that must remain in the central zone whilst the other two players are free to enter and press the ball. The 2 players in the central zone are free to move up and down and screen through passes.'),
            pw.Header(level: 3, child: pw.Text('Key Coaching Points')),
            pw.Paragraph(
                text:
                    '1. Support via creating good angles for the player on the ball'),
            pw.Paragraph(
                text:
                    '2. Create a diamond shape to create good passing angles.'),
            pw.Paragraph(text: '3. Play with open body position'),
            pw.Paragraph(
                text:
                    '4. Play with head up to see opportunities to swtich the play'),
            pw.Paragraph(text: '5. Dont force the switch, be patient.'),
            pw.Paragraph(text: '6. Pace of play should be fast.'),
            pw.Paragraph(
                text: '7. Defenders should press and transtiion immediately'),
            pw.Paragraph(
                text:
                    '8. Transition between attacking and defending must be immediate!'),
            pw.Header(level: 3, child: pw.Text('Variations')),
            pw.Paragraph(text: '1. Switched pass must be an aerial ball.'),
            pw.Paragraph(
                text:
                    '2. Before the defending team switches to offense they must complete a pass to a team mate.'),
            pw.Header(level: 1, child: pw.Text('Long Balls Playstyle')),
            pw.Paragraph(
                text:
                    'If a long ball style of play is what you wish to select, then the following drills should be performed in order to best perform to your expectations:'),
            pw.Header(level: 3, child: pw.Text('Organization')),
            pw.Paragraph(
                text:
                    'Three players progress up the field by passing and overlapping a teammate until they reach the penalty box on the opposite end of the field. The player who has the ball when entering the penalty box attempts a shot on goal.'),
            pw.Header(level: 3, child: pw.Text('Purpose')),
            pw.Paragraph(
                text:
                    'Develops players ability to pass and dribble while moving at speed. Players are forced to pass the ball into their teammates running path and then quickly overlap that player. Players work on receiving a ball on the run and being able to control their first touch while running.'),
            pw.Header(level: 3, child: pw.Text('Setup')),
            pw.Paragraph(
                text:
                    '1. Divide the team into three even lines along the endline.'),
            pw.Paragraph(
                text:
                    '2. Each line should be about 10-15 yards apart depending on the age and skill level of the players.'),
            pw.Paragraph(
                text:
                    '3. Each player in the middle line should start with a ball.'),
            pw.Paragraph(
                text:
                    '4. One player from each line will work together down the field.'),
            pw.Paragraph(
                text:
                    '5. If available, assign a goalkeeper to the goal opposite of the three lines.'),
            pw.Header(level: 3, child: pw.Text('Variations')),
            pw.Paragraph(
                text:
                    '1. Passing distance - Mix up the distance players must pass and overlap. Start small and as players develop, make the distances between players larger.'),
            pw.Paragraph(
                text:
                    '2. Time challenge - Create a time limit that players must pass down the field and score before the time runs out. This challenges the players to pass and move quickly.'),
            pw.Paragraph(
                text:
                    '3. One-touch - Depending on the age and skill level of the players, give the players only one-touch to complete the whole drill.')
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
