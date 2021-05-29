import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:screens_ui/services/event_firestore_services.dart';

class AddGames extends StatefulWidget {
  final DateTime selectedDate;
  AddGames({this.selectedDate});
  @override
  _AddGamesState createState() => _AddGamesState();
}

class _AddGamesState extends State<AddGames> {
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
            color: Color.fromRGBO(186, 15, 48, 1),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Center(
            child: Container(
              padding: EdgeInsets.only(right: 10),
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
                    await scheduleDBS.create(data);

                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(186, 15, 48, 1)),
              ),
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
                    hintText: 'Add Opposition Team',
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
