import 'package:flutter/material.dart';
import 'package:odont/data/data-models/patientModel.dart';

import 'attendPatientDashboard-phone.dart';

class AttendPatientDashboard extends StatefulWidget {
  const AttendPatientDashboard({Key? key, required this.patient})
      : super(key: key);
  final Patient patient;
  @override
  _AttendPatientDashboardState createState() => _AttendPatientDashboardState();
}

class _AttendPatientDashboardState extends State<AttendPatientDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Atendiendo Paciente"),
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 750) {
              // Phone size
              return AttendPatientDashboardPhone(
                patient: widget.patient,
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
