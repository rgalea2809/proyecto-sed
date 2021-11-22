import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:odont/base/constants.dart';
import 'package:odont/data/changeNotifiers/doctorNotifier.dart';
import 'package:odont/data/data-models/userModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserDAO {
  /// Checks user credentials. Two things happen after checking credentials:
  ///
  /// * If credentials match an existing user returns [User].
  /// * If credentials dont math any user it returns 'null'
  static Future<User?> loginUser(
      String email, String password, BuildContext context) async {
    String url =
        "${Provider.of<DoctorNotifier>(context, listen: false).baseUrl}/doctors/login/";
    var loginUrl = Uri.parse(url);

    var response;
    try {
      response = await http
          .post(loginUrl, body: {'email': email, 'password': password});
    } catch (e) {
      print("ERROR POSTING TO SERVER: $e");
      return null;
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn", true);
      await prefs.setString("token", jsonResponse["token"]);
      await prefs.setString("tokenExpeditionDate", DateTime.now().toString());
      print("USERIF: ${jsonResponse["id"]}");

      return User(
          email: email,
          lastName: jsonResponse["lastName"],
          name: jsonResponse["name"],
          token: jsonResponse["token"],
          doctorId: jsonResponse["id"]);
    } else {
      return null;
    }
  }

  /// Logout User
  ///
  /// * Sets isLoggedIn in sharedPreferences to null
  static Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
