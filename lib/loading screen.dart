import 'package:flutter/material.dart';
import 'package:notes_app2/homepage.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2),() {
      Navigator.of(context).pop();
      Navigator.of(context).pushNamed("HomePage");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      child: Image.asset(
        "assets/loadingPage.jpg",
        fit: BoxFit.cover,
      ),
    );
  }
}

