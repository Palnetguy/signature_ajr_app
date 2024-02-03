import 'dart:async';

import 'package:flutter/material.dart';
import 'package:AJR_Ink/constants/constants.dart';

import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 13),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePageScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundColor,
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text("Signaure PDF App"),
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(color: Colors.teal.shade300),
            )
          ],
        ),
      ),
    );
  }
}
