import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/Screens/todo_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => TodoHome()));
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Image(
          image: AssetImage("asset/image/todologo.png"),
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width * 0.65,
        ),
      ),
    );
  }
}
