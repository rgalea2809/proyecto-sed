import 'package:flutter/material.dart';
import 'package:odont/custom-widgets/DashboardCard.dart';
import 'package:odont/screens/attent-patient-screen/attendPatient.dart';

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
                print("Tapped Registro de Citas");
              },
              aspectRatio: aspectRatio,
            ),
            DashboardCard(
              title: "Ver Registro de Pacientes",
              onTapped: () {
                print("Tapped Registro de Pacientes");
              },
              aspectRatio: aspectRatio,
            ),
          ],
        ),
      ),
    );
  }
}
