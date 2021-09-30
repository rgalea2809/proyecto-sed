import 'package:flutter/material.dart';
import 'package:odont/screens/login-screen/login-large.dart';
import 'package:odont/screens/login-screen/login-largest.dart';
import 'package:odont/screens/login-screen/login-phone.dart';
import 'package:odont/screens/login-screen/login-tablet.dart';

class LoginScreen extends StatefulWidget {
  final String id = "login-screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Returns phone size layout
  Widget _phoneLayout() {
    return LoginScreenPhone();
  }

  Widget _tabletLayout() {
    return LoginScreenTablet();
  }

  Widget _largeLayout() {
    return LoginScreenLarge();
  }

  Widget _largestLayout() {
    return LoginScreenLargest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 600) {
              // Phone size
              return _phoneLayout();
            } else if (constraints.maxWidth > 600 &&
                constraints.maxWidth < 992) {
              // Tablet size
              return _tabletLayout();
            } else if (constraints.maxWidth > 992 &&
                constraints.maxWidth < 1200) {
              // large size
              return _largeLayout();
            } else {
              //largest size
              return _largestLayout();
            }
          },
        ),
      ),
    );
  }
}
