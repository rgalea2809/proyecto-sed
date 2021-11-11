import 'dart:async';

import 'package:flutter/material.dart';
import 'package:odont/data/changeNotifiers/doctorNotifier.dart';
import 'package:odont/data/data-models/userModel.dart';
import 'package:odont/screens/home-screen/home.dart';
import 'package:odont/screens/login-screen/login.dart';
import 'package:provider/provider.dart';
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
    var tokenExpeditionDate = prefs.getString("tokenExpeditionDate") ?? "";
    bool tokenHasExpired = true;
    User? currentDoctor =
        Provider.of<DoctorNotifier>(context, listen: false).currentDoctor;

    if (tokenExpeditionDate.isNotEmpty &&
        DateTime.now().difference(DateTime.parse(tokenExpeditionDate)).inHours <
            8) {
      print(
          "HOURS PASSED: ${DateTime.now().difference(DateTime.parse(tokenExpeditionDate)).inHours}");
      tokenHasExpired = false;
    } else {
      print('Token expired;!!!');
    }

    if (status && !tokenHasExpired && currentDoctor != null) {
      Navigator.pushReplacementNamed(context, HomeScreen().id);
    } else {
      await prefs.setBool("isLoggedIn", false);
      await prefs.setString("tokenExpeditionDate", "");
      Navigator.pushReplacementNamed(context, LoginScreen().id);
    }
  }
}
