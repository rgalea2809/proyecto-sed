class Appointment {
  Appointment({
    required this.patientId,
    required this.doctorId,
    required this.date,
    this.appointmentId,
    this.appointmentType,
    this.medicine,
    this.info,
    this.treatmentId,
  });

  String patientId;
  String doctorId;
  DateTime date;
  String? appointmentId;
  String? appointmentType;
  List<String>? medicine;
  String? info;
  String? treatmentId;
}
