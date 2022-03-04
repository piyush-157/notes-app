import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app2/EditNoteScreen.dart';
import 'package:notes_app2/homepage.dart';
import 'package:notes_app2/loading%20screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        "HomePage": (BuildContext context) => HomePage(),
        "SplashScreen": (BuildContext context) => SplashScreen(),
        "EditNoteScreen": (BuildContext context) => EditNoteScreen()
      },
    );
  }
}