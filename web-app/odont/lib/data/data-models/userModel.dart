class User {
  User(
      {required this.email,
      required this.lastName,
      required this.name,
      required this.token,
      required this.doctorId});
  String email;
  String name;
  String lastName;
  String token;
  String doctorId;

  /// Return full name.
  ///
  /// Concatenates [name] and [lastName]
  String getFullName() {
    return "$name $lastName";
  }
}
