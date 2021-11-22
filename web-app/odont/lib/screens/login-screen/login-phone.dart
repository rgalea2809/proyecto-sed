import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:odont/base/constants.dart';
import 'package:odont/data/DAOs/userDAO.dart';
import 'package:odont/data/changeNotifiers/doctorNotifier.dart';
import 'package:odont/data/data-models/userModel.dart';
import 'package:odont/screens/home-screen/home.dart';
import 'package:provider/provider.dart';

class LoginScreenPhone extends StatefulWidget {
  @override
  _LoginScreenPhoneState createState() => _LoginScreenPhoneState();
}

class _LoginScreenPhoneState extends State<LoginScreenPhone> {
  final _loginFormKey = GlobalKey<FormState>();
  String _currentEmail = "";
  String _currentPassword = "";
  String _newApiUrl = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * (3 / 4),
          maxWidth: 600,
        ),
        margin: EdgeInsets.all(20),
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
                  onChanged: (newValue) {
                    _currentEmail = newValue;
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
                    // check user login
                    User? loggedUser = await UserDAO.loginUser(
                        _currentEmail, _currentPassword, context);

                    if (loggedUser == null) {
                      Fluttertoast.showToast(
                          msg: "Error: Compruebe sus credenciales");
                    } else {
                      print("Log successful");
                      Provider.of<DoctorNotifier>(context, listen: false)
                          .setDoctor(loggedUser);
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
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue:
                            Provider.of<DoctorNotifier>(context, listen: true)
                                .baseUrl,
                        onChanged: (newValue) {
                          _newApiUrl = newValue;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.data_usage_outlined),
                          labelText: 'API URL',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_newApiUrl.isNotEmpty) {
                          Provider.of<DoctorNotifier>(context, listen: false)
                              .setBaseUrl(_newApiUrl);
                          Fluttertoast.showToast(
                              msg: "URL MODIFICADA: $_newApiUrl");
                        }
                      },
                      child: Text("Cambiar URL de API"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
