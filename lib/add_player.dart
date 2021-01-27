import 'package:flutter/material.dart';
import 'squad_list.dart';

class AddPlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Player',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("ENTER PLAYER DATA",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
          TextField(
            obscureText: false,
            style: TextStyle(
                fontSize: 20.0
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: 'Player Name',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(70.0)),
            ),
          ),
          SizedBox(height: 30.0,),
          TextField(
            obscureText: false,
            style: TextStyle(
                fontSize: 20.0
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: 'Player Position',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(70.0)),
            ),
          ),
          SizedBox(height: 30.0,),
          TextField(
            obscureText: false,
            style: TextStyle(
                fontSize: 20.0
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: 'Attack Stat',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(70.0)),
            ),
          ),
          SizedBox(height: 30.0,),
          TextField(
            obscureText: false,
            style: TextStyle(
                fontSize: 20.0
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: 'Midfield Stat',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(70.0)),
            ),
          ),
          SizedBox(height: 30.0,),
          TextField(
            obscureText: false,
            style: TextStyle(
                fontSize: 20.0
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: 'Defense Stat',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(70.0)),
            ),
          ),
          SizedBox(height: 30.0,),
          TextField(
            obscureText: false,
            style: TextStyle(
                fontSize: 20.0
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: 'Goalkeeping Stat',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(70.0)),
            ),
          ),
          SizedBox(height: 30.0,),
          MaterialButton(onPressed: (){
            navigateToSquadList(context);
          },
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              child: Text('CONFIRM PLAYER INFORMATION',style: TextStyle(color: Colors.white, backgroundColor: Colors.black),
              )),
        ],
      ),
    );
  }
}

Future navigateToAddPlayerpage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => AddPlayerPage()));
}