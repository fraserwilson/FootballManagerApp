import 'package:flutter/material.dart';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SUMMARY PAGE'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text('PLayers, Playstyle and formation(Plus image) shows here'),
      ),
    );
  }
}

Future navigateToSummarypage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => SummaryPage()));
}
