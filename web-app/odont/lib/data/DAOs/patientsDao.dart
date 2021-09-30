import 'package:odont/data/data-models/patientModel.dart';

class PatientsDAO {
  /// Returns all of the patients registered in the database
  ///
  static Future<List<Patient>> getAllPatients() async {
    List<Patient> patients = [];
    await Future.delayed(Duration(seconds: 1));

    for (int i = 0; i < 5; i++) {
      Patient newPatient = Patient(
          email: "email$i@email.com",
          name: "Patient$i",
          phone: "7885066$i",
          birthDate: DateTime(1990, 10, i),
          lastName: "mejia$i",
          medicalConditions: ["Hipertension nivel 2", "HIpertrofia 3"],
          patientId: "assDsdf$i",
          sex: i % 2 == 0 ? "Masculino" : "Femenino",
          weigh: (100.0 + i));

      patients.add(newPatient);
    }

    return patients;
  }

  /// Returns all of the patients that match the entered name or data
  ///
  /// If String matches an existing patient adds it to the list
  /// Checks for name, email and phone number
  static Future<List<Patient>> getMatchingPatients(String search) async {
    List<Patient> patients = await getAllPatients();

    List<Patient> matchingPatients = [];

    patients.forEach((patient) {
      if (patient.getFullName().toLowerCase().contains(search.toLowerCase()) ||
          patient.email.toLowerCase().contains(search.toLowerCase()) ||
          patient.phone.toLowerCase().contains(search.toLowerCase())) {
        matchingPatients.add(patient);
      }
    });

    return matchingPatients;
  }
}
