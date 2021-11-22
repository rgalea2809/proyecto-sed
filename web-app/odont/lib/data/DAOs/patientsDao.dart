import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:odont/data/changeNotifiers/doctorNotifier.dart';
import 'package:odont/data/data-models/appointmentModel.dart';
import 'package:odont/data/data-models/patientModel.dart';
import 'package:http/http.dart' as http;
import 'package:odont/base/constants.dart';
import 'package:odont/data/data-models/treatmentModel.dart';
import 'package:provider/provider.dart';

class PatientsDAO {
  // Create new patient
  static Future<bool> createPatient(
      Patient patient, String token, BuildContext context) async {
    String url =
        "${Provider.of<DoctorNotifier>(context, listen: false).baseUrl}/patients/";
    var postAppointmentUrl = Uri.parse(url);

    var response;
    try {
      response = await http.post(postAppointmentUrl, headers: {
        "Authorization": "Bearer $token"
      }, body: {
        "birthDate": DateTime.now().toIso8601String(),
        "name": patient.name,
        "lastName": patient.lastName,
        "weight": patient.weight.toString(),
        "sex": patient.sex,
        "medicalConditions": "Yes",
        "email": patient.email,
        "phone": patient.phone,
      });
      print("SAVED PATIENT");
    } catch (e) {
      print("ERROR SAVING PATIENT: $e");
      return false;
    }

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  /// Returns all of the patients registered in the database
  ///
  static Future<List<Patient>> getAllPatients(
      String token, BuildContext context) async {
    List<Patient> retrievedPatients = [];
    String url =
        "${Provider.of<DoctorNotifier>(context, listen: false).baseUrl}/patients/";
    var getPatientsUrl = Uri.parse(url);

    var response;
    try {
      response = await http
          .get(getPatientsUrl, headers: {"Authorization": "Bearer $token"});
      print("GOT PATIENTS | status: ${response.statusCode}");
    } catch (e) {
      print("ERROR GETTING PATIENTS FROM SERVER: $e");
    }

    //parsed response
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      try {
        List<dynamic> patients = jsonResponse["patients"];
        print("PATIENTS QTY: ${jsonResponse["count"]}");
        for (int i = 0; i < jsonResponse["count"]; i++) {
          Patient newPatient = Patient(
            email: patients[i]["email"],
            name: patients[i]["name"],
            phone: patients[i]["phone"],
            birthDate: DateTime.parse(patients[i]["birthDate"]),
            lastName: patients[i]["lastName"],
            medicalConditions: patients[i]["medicalConditions"].cast<String>(),
            patientId: patients[i]["_id"],
            sex: patients[i]["sex"],
            weight: double.parse(patients[i]["weight"]["\$numberDecimal"]),
          );
          retrievedPatients.add(newPatient);
        }
      } catch (e) {
        print("Error trying to parse patients reponse: $e");
      }
    }

    return retrievedPatients;
  }

  /// Returns all of the patients that match the entered name or data
  ///
  /// If String matches an existing patient adds it to the list
  /// Checks for name, email and phone number
  static Future<List<Patient>> getMatchingPatients(
      String search, String token, BuildContext context) async {
    List<Patient> patients = await getAllPatients(token, context);

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

  //Saves appointment to database
  static Future<bool> saveAppointment(Patient patient, String doctorId,
      String appointmentInfo, String token, BuildContext context) async {
    String url =
        "${Provider.of<DoctorNotifier>(context, listen: false).baseUrl}/appointments/";
    var postAppointmentUrl = Uri.parse(url);

    var response;
    try {
      response = await http.post(postAppointmentUrl, headers: {
        "Authorization": "Bearer $token"
      }, body: {
        "date": DateTime.now().toIso8601String(),
        "info": appointmentInfo,
        "patientId": patient.patientId,
        "doctorId": doctorId,
      });
      print("GOT PATIENTS | status: ${response.statusCode}");
    } catch (e) {
      print("ERROR POSTING APPOINTMENT: $e");
      return false;
    }

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  //Get all appointments
  static Future<List<Appointment>> getAllAppointments(
      String token, BuildContext context) async {
    List<Appointment> retrievedAppointments = [];
    String url =
        "${Provider.of<DoctorNotifier>(context, listen: false).baseUrl}/appointments/";
    var getAppointmentsUrl = Uri.parse(url);

    var response;
    try {
      response = await http
          .get(getAppointmentsUrl, headers: {"Authorization": "Bearer $token"});
      print("GOT APPOINTMENTS | status: ${response.statusCode}");
    } catch (e) {
      print("ERROR GETTING APPOINTMENTS FROM SERVER: $e");
    }

    //parsed response
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      try {
        List<dynamic> appointments = jsonResponse["appointments"];
        print("APPOINTMENTS QTY: ${jsonResponse["count"]}");
        for (int i = 0; i < jsonResponse["count"]; i++) {
          Appointment newAppointment = Appointment(
            date: DateTime.parse(appointments[i]["date"]),
            doctorId: appointments[i]["doctorId"],
            patientId: appointments[i]["patientId"],
            info: appointments[i]["info"],
          );
          retrievedAppointments.add(newAppointment);
        }
      } catch (e) {
        print("Error trying to parse appointments reponse: $e");
      }
    }

    return retrievedAppointments;
  }

  //Gets all of the patients appointments
  static Future<List<Appointment>> getPatientAppointments(
      Patient patient, String token, BuildContext context) async {
    print("GETTING APPOINTMENTS");
    List<Appointment> appointments = await getAllAppointments(token, context);

    List<Appointment> patientAppointments = [];

    appointments.forEach((appointment) {
      if (appointment.patientId == patient.patientId) {
        patientAppointments.add(appointment);
      }
    });

    return patientAppointments;
  }

  //Deprecated
  // Returns the treatments tied to the [Patient]
  static Future<List<Treatment>> getPatientTreatments(
      Patient patient, String token, BuildContext context) async {
    List<Treatment> retrievedTreatments = [];
    String url =
        "${Provider.of<DoctorNotifier>(context, listen: false).baseUrl}/treatments/";
    var getTreatmentsUrl = Uri.parse(url);

    var response;
    try {
      response = await http
          .get(getTreatmentsUrl, headers: {"Authorization": "Bearer $token"});
      print("GOT PATIENTS | status: ${response.statusCode}");
    } catch (e) {
      print("ERROR GETTING PATIENTS FROM SERVER: $e");
    }

    //parsed response
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      try {
        List<dynamic> treatments = jsonResponse["treatments"];
        print("PATIENTS QTY: ${jsonResponse["count"]}");
        for (int i = 0; i < jsonResponse["count"]; i++) {
          if (treatments[i]["patientId"] == patient.patientId) {
            Treatment newTreatment = Treatment(
              treatmentId: treatments[i]["id"],
              doctorId: treatments[i]["doctorId"],
              patientId: treatments[i]["patientId"],
              dateOfCreation: DateTime.parse(treatments[i]["dateOfCreation"]),
              treatmentName: treatments[i]["treatmentName"],
            );
            retrievedTreatments.add(newTreatment);
          }
        }
      } catch (e) {
        print("Error trying to parse patients reponse: $e");
      }
    }

    return retrievedTreatments;
  }
}
