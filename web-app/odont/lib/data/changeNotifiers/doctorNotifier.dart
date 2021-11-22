import 'package:flutter/cupertino.dart';
import 'package:odont/data/data-models/userModel.dart';

class DoctorNotifier extends ChangeNotifier {
  /// Internal, private state of the doctor.
  User? currentDoctor;
  String token = "";
  bool isSignedIn = false;

  /// Internal, private state of the doctor.
  String _baseUrl = "http://localhost:3000/api";

  /// The current doctor signed in
  String get baseUrl => _baseUrl;

  /// set current [_baseUrl]
  void setBaseUrl(String string) {
    _baseUrl = string;
    notifyListeners();
  }

  /// The current doctor signed in
  User? get doctor => currentDoctor;

  /// set current [doctor]
  void setDoctor(User doctor) {
    currentDoctor = doctor;
    isSignedIn = true;
    token = doctor.token;
    print("DOCTOR SET SUCCESSFULLY");
    notifyListeners();
  }

  /// Removes current signed doctor and its credentials
  void clearDoctor() {
    currentDoctor = null;
    isSignedIn = false;
    token = "";
    notifyListeners();
  }
}
