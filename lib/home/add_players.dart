import 'package:flutter/material.dart';

class AddPlayersFo extends StatefulWidget {
  @override
  _AddPlayersFoState createState() => _AddPlayersFoState();
}

class _AddPlayersFoState extends State<AddPlayersFo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Add New Player',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
