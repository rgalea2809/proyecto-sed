import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:odont/base/constants.dart';
import 'package:odont/data/DAOs/userDAO.dart';
import 'package:odont/data/data-models/userModel.dart';
import 'package:odont/screens/home-screen/home.dart';

class LoginScreenLarge extends StatefulWidget {
  @override
  _LoginScreenLargeState createState() => _LoginScreenLargeState();
}

class _LoginScreenLargeState extends State<LoginScreenLarge> {
  final _loginFormKey = GlobalKey<FormState>();
  String _currentEmail = "";
  String _currentPassword = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * (3 / 4),
          maxWidth: 650,
        ),
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: Form(
          key: _loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle_rounded,
                size: 35,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  onChanged: (value) {
                    _currentEmail = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    hintText: 'correo@email.com',
                    labelText: 'Email',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Ingrese su correo";
                    } else if (!kEmailRegexString.hasMatch(value)) {
                      return "Ingrese un correo válido";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  obscureText: true,
                  onChanged: (newValue) {
                    _currentPassword = newValue;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Contraseña',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Ingrese su contraseña";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_loginFormKey.currentState!.validate()) {
                    print("validated");
                    print(_currentPassword);
                    print(_currentEmail);

                    // check user login
                    User? loggedUser = await UserDAO.loginUser(
                        _currentEmail, _currentPassword);

                    if (loggedUser == null) {
                      Fluttertoast.showToast(
                          msg: "Error: Compruebe sus credenciales");
                    } else {
                      Navigator.pushReplacementNamed(context, HomeScreen().id);
                    }
                  }
                },
                child: Text(
                  "CONFIRMAR",
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
