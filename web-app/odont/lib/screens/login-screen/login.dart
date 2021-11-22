import 'package:flutter/material.dart';
import 'package:odont/screens/login-screen/login-phone.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return _phoneLayout();
          },
        ),
      ),
    );
  }
}
