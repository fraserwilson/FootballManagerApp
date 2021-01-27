import 'package:flutter/material.dart';
import 'edit_player.dart';
import 'add_player.dart';
import 'playstyle.dart';

class SquadList extends StatefulWidget {
  @override
  _SquadListState createState() => _SquadListState();
}

class _SquadListState extends State<SquadList> {
  List<String> Names = [
    'Fraser','Andy', 'John','Robert','Sally','Jesse', 'Norman'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Squad List'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (_,int index)=>PlayerList(this.Names[index]),
          itemCount: this.Names.length,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton(onPressed: (){navigateToAddPlayerpage(context);}, child: Text("ADD NEW PLAYER",style: TextStyle(color: Colors.white, backgroundColor: Colors.black),),),
            FlatButton(onPressed: (){navigateToPlaystylepage(context);}, child: Text("CONFIRM SQUAD LIST",style: TextStyle(color: Colors.white, backgroundColor: Colors.black),),),
          ],
        ),
      ),
    );
  }
}

class PlayerList extends StatelessWidget {
  final String name;
  PlayerList(this.name);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  child: Text(name[0],
                    style: TextStyle(
                        color: Colors.white
                    ),),
                  backgroundColor: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                ),
                Text(name,
                  style: TextStyle(
                      fontSize: 20.0
                  ),),
                IconButton(onPressed: (){
                  navigateToEditpage(context);
                },
                    icon: Icon(Icons.app_registration)),
                IconButton(onPressed: (){
                },
                    icon: Icon(Icons.delete)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future navigateToSquadList(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => SquadList()));
}