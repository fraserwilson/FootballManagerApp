import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  final DateTime selectedDate;
  AddEvent({this.selectedDate});
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                _formKey.currentState.save();
              },
              child: Text('Save'),
            ),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          FormBuilder(
            child: Column(
              children: <Widget>[
                FormBuilderTextField(
                  attribute: 'Title',
                  decoration: InputDecoration(
                    hintText: 'Add Title',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 8.0),
                  ),
                ),
                Divider(),
                FormBuilderTextField(
                  attribute: 'Description',
                  maxLines: 5,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add Details',
                    prefixIcon: Icon(Icons.short_text),
                  ),
                ),
                Divider(),
                FormBuilderDateTimePicker(
                  attribute: 'date',
                  initialValue: widget.selectedDate ?? DateTime.now(),
                  inputType: InputType.date,
                  format: DateFormat('EEEE,dd MMMM, yyyy'),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.calendar_today_sharp)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
