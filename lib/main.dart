import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screens_ui/models/user.dart';
import 'package:screens_ui/services/auth.dart';
import 'wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<ConvertedUser>.value(
            value: AuthService().streamuser,
          ),
        ],
        child: MaterialApp(
            theme: ThemeData(fontFamily: 'SyneMono'), home: Wrapper()));
  }
}
