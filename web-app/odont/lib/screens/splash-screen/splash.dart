import 'dart:async';

import 'package:flutter/material.dart';
import 'package:odont/screens/home-screen/home.dart';
import 'package:odont/screens/login-screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;

    if (status) {
      Navigator.pushReplacementNamed(context, HomeScreen().id);
    } else {
      Navigator.pushReplacementNamed(context, LoginScreen().id);
    }
  }
}
