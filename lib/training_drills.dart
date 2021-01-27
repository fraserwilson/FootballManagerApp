import 'package:flutter/material.dart';

class TrainingPage extends StatefulWidget {
  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TRAINING PAGE', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children:<Widget>[
                  Text('GOALKEEPING DRILLS',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  Divider(height: 40.0, thickness: 2.0,),
                  Text('Training Drill 1: ',style: TextStyle(fontSize: 20.0, ),),
                  Text('Training Drill 2: ',style: TextStyle(fontSize: 20.0, ),),
                  Text('Training Drill 3: ',style: TextStyle(fontSize: 20.0, ),),
                  Divider(height: 40.0, thickness: 2.0,),

                  Text('DEFENSIVE DRILLS',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  Divider(height: 40.0, thickness: 2.0,),
                  Text('Training Drill 1: ',style: TextStyle(fontSize: 20.0, ),),
                  Text('Training Drill 2: ',style: TextStyle(fontSize: 20.0, ),),
                  Text('Training Drill 3: ',style: TextStyle(fontSize: 20.0, ),),
                  Divider(height: 40.0, thickness: 2.0,),

                  Text('MIDFIELD DRILLS',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  Divider(height: 40.0, thickness: 2.0,),
                  Text('Training Drill 1: ',style: TextStyle(fontSize: 20.0, ),),
                  Text('Training Drill 2: ',style: TextStyle(fontSize: 20.0, ),),
                  Text('Training Drill 3: ',style: TextStyle(fontSize: 20.0, ),),
                  Divider(height: 40.0, thickness: 2.0,),

                  Text('ATTACK DRILLS',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                  Divider(height: 40.0, thickness: 2.0,),
                  Text('Training Drill 1: ',style: TextStyle(fontSize: 20.0, ),),
                  Text('Training Drill 2: ',style: TextStyle(fontSize: 20.0, ),),
                  Text('Training Drill 3: ',style: TextStyle(fontSize: 20.0, ),),
                  Divider(height: 40.0, thickness: 2.0,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future navigateToTraningpage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => TrainingPage()));
}