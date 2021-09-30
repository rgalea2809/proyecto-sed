class User {
  User({
    required this.email,
    required this.lastName,
    required this.name,
  });
  String email;
  String name;
  String lastName;

  /// Return full name.
  ///
  /// Concatenates [name] and [lastName]
  String getFullName() {
    return "$name $lastName";
  }
}
