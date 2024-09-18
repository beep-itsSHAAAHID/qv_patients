import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qv_patient/auth_checker.dart';
import 'dart:async';

import 'package:qv_patient/navigationmenu.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(CupertinoPageRoute(
        builder: (context) {
          return AuthenticationCheck();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/qv_logo.png'), // Your splash screen image
      ),
    );
  }
}
