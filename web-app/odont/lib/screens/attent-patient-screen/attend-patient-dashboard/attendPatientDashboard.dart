import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:odont/data/DAOs/patientsDao.dart';
import 'package:odont/data/changeNotifiers/doctorNotifier.dart';
import 'package:odont/data/data-models/patientModel.dart';
import 'package:provider/provider.dart';

import 'attendPatientDashboard-phone.dart';

class AttendPatientDashboard extends StatefulWidget {
  const AttendPatientDashboard({Key? key, required this.patient})
      : super(key: key);
  final Patient patient;
  @override
  _AttendPatientDashboardState createState() => _AttendPatientDashboardState();
}

class _AttendPatientDashboardState extends State<AttendPatientDashboard> {
  String consultaInfo = "";

  void endConsultaDialog(String notes, Patient patient) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Terminar consulta"),
            content: Text("Desea finalizar la consulta?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancelar"),
              ),
              ElevatedButton(
                onPressed: () async {
                  bool savedAppointment = await PatientsDAO.saveAppointment(
                      widget.patient,
                      Provider.of<DoctorNotifier>(context, listen: false)
                          .currentDoctor!
                          .doctorId,
                      consultaInfo,
                      Provider.of<DoctorNotifier>(context, listen: false)
                          .token);

                  if (savedAppointment) {
                    Fluttertoast.showToast(msg: "Guardado Exitosamente");
                    Navigator.popUntil(context, (route) => route.isFirst);
                  } else {
                    Fluttertoast.showToast(msg: "Error!");
                  }
                },
                child: Text("Confirmar"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Atendiendo Paciente"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          endConsultaDialog(consultaInfo, widget.patient);
        },
        child: Icon(Icons.check),
      ),
      body: SingleChildScrollView(
        child: AttendPatientDashboardPhone(
            patient: widget.patient,
            onTextChanged: (String newText) {
              consultaInfo = newText;
            }),
      ),
    );
  }
}
