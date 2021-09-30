import 'package:flutter/material.dart';
import 'package:odont/custom-widgets/DashboardCard.dart';
import 'package:odont/screens/attent-patient-screen/attendPatient.dart';

class HomeLarge extends StatefulWidget {
  @override
  _HomeLargeState createState() => _HomeLargeState();
}

class _HomeLargeState extends State<HomeLarge> {
  double aspectRatio = 1;

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
            Row(
              children: [
                DashboardCard(
                    title: "Atender Paciente",
                    onTapped: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => AttendPatient()));
                    },
                    aspectRatio: aspectRatio),
                DashboardCard(
                    title: "Registro de Citas",
                    onTapped: () {
                      print("Tapped Citas");
                    },
                    aspectRatio: aspectRatio),
              ],
            ),
            Row(
              children: [
                DashboardCard(
                    title: "Ver Registro de Pacientes",
                    onTapped: () {
                      print("Tapepd pacientes");
                    },
                    aspectRatio: aspectRatio),
              ],
            )
          ],
        ),
      ),
    );
  }
}
