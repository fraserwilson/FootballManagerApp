import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:screens_ui/services/event_firestore_services.dart';

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
                bool validated = _formKey.currentState.validate();
                print(validated);
                if (validated) {
                  _formKey.currentState.save();
                  final data =
                      Map<String, dynamic>.from(_formKey.currentState.value);
                  String uid = FirebaseAuth.instance.currentUser.uid;
                  data['userId'] = uid;
                  await eventDBS.create(data);

                  Navigator.pop(context);
                }
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
            key: _formKey,
            child: Column(
              children: <Widget>[
                FormBuilderTextField(
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  attribute: 'title',
                  decoration: InputDecoration(
                    hintText: 'Add Title',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 8.0),
                  ),
                ),
                Divider(),
                FormBuilderTextField(
                  attribute: 'description',
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
                  validators: [FormBuilderValidators.required()],
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
