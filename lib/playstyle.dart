import 'package:flutter/material.dart';
import 'schedule.dart';
import 'training_drills.dart';
import 'results.dart';
import 'summary.dart';

class Item {
  const Item(this.name);
  final String name;
}

class Formation{
  const Formation(this.name);
  final String name;
}


class PlaystylePage extends StatefulWidget {

  @override
  _PlaystylePageState createState() => _PlaystylePageState();
}

class _PlaystylePageState extends State<PlaystylePage> {
  Item selectedUser;

  List<Item> playstyles = <Item>[
    const Item('Attacking',),
    const Item('Tiki-Taka',),
    const Item('Low-Block',),
    const Item('Wing-Play',),
  ];

  Formation selectedFormation;

  List<Formation> formations = <Formation>[
    const Formation('4-4-2',),
    const Formation('4-3-3',),
    const Formation('4-2-3-1',),
    const Formation('5-3-2',),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Playstyle Page'),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          DropdownButton<Item>(
            hint: Text("Select Playstyle"),
            value: selectedUser,
            onChanged: (Item Value){
              setState(() {
                selectedUser = Value;
              });
            },
            items: playstyles.map((Item user){
              return DropdownMenuItem<Item>(
                value: user,
                child: Row(
                  children: <Widget>[
                    Text(user.name, style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          DropdownButton<Formation>(
            hint: Text("Select Formation"),
            value: selectedFormation,
            onChanged: (Formation Value){
              setState(() {
                selectedFormation = Value;
              });
            },
            items: formations.map((Formation user){
              return DropdownMenuItem<Formation>(
                value: user,
                child: Row(
                  children: <Widget>[
                    Text(user.name, style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 120.0,
        height: 120.0,
        child: FloatingActionButton(
          onPressed: (){
            navigateToSummarypage(context);
          },
          child: Text("CONFIRM PLAYSTYLE",style: TextStyle(color: Colors.white,), textAlign: TextAlign.center,),backgroundColor:Colors.black, ),),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(onPressed: (){
              navigateToSchedulepage(context);
            }, child: Text("SCHEDULE",style: TextStyle(color: Colors.white, backgroundColor: Colors.black),),),
            FlatButton(onPressed: (){
              navigateToTraningpage(context);
            }, child: Text("TRAINING DRILLS",style: TextStyle(color: Colors.white, backgroundColor: Colors.black),),),
            FlatButton(onPressed: (){
              navigateToResultspage(context);
            }, child: Text("RESULTS",style: TextStyle(color: Colors.white, backgroundColor: Colors.black),),),
          ],
        ),
      ),
    );
  }
}

Future navigateToPlaystylepage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => PlaystylePage()));
}