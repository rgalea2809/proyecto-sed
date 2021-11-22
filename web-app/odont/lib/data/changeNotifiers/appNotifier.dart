import 'package:flutter/cupertino.dart';
import 'package:odont/data/data-models/userModel.dart';

class AppNotifier extends ChangeNotifier {
  /// Internal, private state of the doctor.
  String _baseUrl = "http://localhost:3000/api";

  /// The current doctor signed in
  String get baseUrl => _baseUrl;

  /// set current [_baseUrl]
  void setUrl(String string) {
    _baseUrl = string;
    notifyListeners();
  }
}
