import 'package:flutter/material.dart';

class PlayerDetails extends StatefulWidget {
  final String name;
  final String position;
  final int attack;
  final int midfield;
  final int defense;
  final int goalkeeping;
  final bool isAvaliable;

  PlayerDetails(
      {this.name,
      this.position,
      this.attack,
      this.midfield,
      this.defense,
      this.goalkeeping,
      this.isAvaliable});
  @override
  _PlayerDetailsState createState() => _PlayerDetailsState();
}

class _PlayerDetailsState extends State<PlayerDetails> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(186, 15, 48, 1),
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Player Details'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Card(
            elevation: 0,
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    'Player name: ' + widget.name ?? 'Test Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    'Player position: ' + widget.position ?? 'Test Position',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    'Player attacking stat: ' + widget.attack.toString() ??
                        'Test Attack',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    'Player midfield stat: ' + widget.midfield.toString() ??
                        'Test Midfield',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    'Player defensive stat: ' + widget.defense.toString() ??
                        'Test Defense',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    'Player goalkeeping stat: ' +
                            widget.goalkeeping.toString() ??
                        'Test Goalkeeping',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    'Player avaliability: ' + widget.isAvaliable.toString() ??
                        'Test Avaliability',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
