import 'package:odont/data/data-models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDAO {
  /// Checks user credentials. Two things happen after checking credentials:
  ///
  /// * If credentials match an existing user returns [User].
  /// * If credentials dont math any user it returns 'null'
  static Future<User?> loginUser(String email, String password) async {
    if (email == "admin@admin.com" && password == "admin") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn", true);
      return User(email: email, lastName: "Mejia", name: "Rodrigo Ernesto");
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
