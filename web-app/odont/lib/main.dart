import 'package:flutter/material.dart';
import 'package:odont/base/constants.dart';
import 'package:odont/screens/home-screen/home.dart';
import 'package:odont/screens/splash-screen/splash.dart';
import 'screens/login-screen/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Odonto App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: kTextTheme,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        LoginScreen().id: (context) => LoginScreen(),
        HomeScreen().id: (context) => HomeScreen(),
      },
    );
  }
}
