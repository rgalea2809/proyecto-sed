import 'package:flutter/material.dart';
import 'package:odont/screens/attent-patient-screen/attendPatient-large.dart';
import 'package:odont/screens/attent-patient-screen/attendPatient-phone.dart';

class AttendPatient extends StatefulWidget {
  @override
  _AttendPatientState createState() => _AttendPatientState();
}

class _AttendPatientState extends State<AttendPatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seleccione el Paciente a Atender"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 750) {
              // Phone size
              return AttendPatientPhone();
            } else {
              return AttendPatientDesktop();
            }
          },
        ),
      ),
    );
  }
}
