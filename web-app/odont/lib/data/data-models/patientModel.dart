class Patient {
  Patient(
      {required this.email,
      required this.name,
      required this.phone,
      required this.birthDate,
      required this.lastName,
      required this.medicalConditions,
      required this.patientId,
      required this.sex,
      required this.weigh});
  String patientId;
  String name;
  String lastName;
  DateTime birthDate;
  double weigh;
  String sex;
  List<String> medicalConditions;
  String email;
  String phone;

  /// Returns patient's age
  int getPatientAge() {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  /// Return full name.
  ///
  /// Concatenates [name] and [lastName]
  String getFullName() {
    return "$name $lastName";
  }
}
