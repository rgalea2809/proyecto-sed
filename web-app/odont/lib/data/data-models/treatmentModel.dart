import 'package:odont/data/data-models/appointmentModel.dart';

class Treatment {
  Treatment({
    required this.treatmentId,
    required this.doctorId,
    required this.patientId,
    this.appointments,
    required this.dateOfCreation,
    required this.payed,
    required this.totalCostOfTreatment,
    required this.treatmentName,
  });
  String treatmentId;
  String patientId;
  String doctorId;
  String treatmentName;
  DateTime dateOfCreation;
  List<Appointment>? appointments;
  double totalCostOfTreatment;
  double payed;
}
