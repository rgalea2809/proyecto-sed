import 'package:flutter/material.dart';
import 'package:odont/custom-widgets/DashboardCard.dart';
import 'package:odont/data/changeNotifiers/doctorNotifier.dart';
import 'package:odont/screens/appointment-registry-screen/appointment_registry_menu.dart';
import 'package:odont/screens/attent-patient-screen/attendPatient.dart';
import 'package:odont/screens/patients-registry/patients-registry.dart';
import 'package:provider/provider.dart';

class HomeSmall extends StatefulWidget {
  @override
  _HomeSmallState createState() => _HomeSmallState();
}

class _HomeSmallState extends State<HomeSmall> {
  double aspectRatio = 3 / 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 600,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Consumer<DoctorNotifier>(
                builder: (context, doctor, child) {
                  return Text("Bienvenido Dr. ${doctor.doctor?.name}");
                },
              ),
            ),
            DashboardCard(
              title: "Atender Paciente",
              onTapped: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AttendPatient()));
              },
              aspectRatio: aspectRatio,
            ),
            DashboardCard(
              title: "Registro de Citas",
              onTapped: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AppointmentRegistryMenu()));
              },
              aspectRatio: aspectRatio,
            ),
            DashboardCard(
              title: "Registro de Pacientes",
              onTapped: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => PatientsRegistry()));
              },
              aspectRatio: aspectRatio,
            ),
          ],
        ),
      ),
    );
  }
}
