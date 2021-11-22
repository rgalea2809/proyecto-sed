import 'package:flutter/material.dart';
import 'package:odont/data/DAOs/patientsDao.dart';
import 'package:odont/data/changeNotifiers/doctorNotifier.dart';
import 'package:odont/data/data-models/appointmentModel.dart';
import 'package:odont/data/data-models/patientModel.dart';
import 'package:provider/provider.dart';

class AppointmentList extends StatefulWidget {
  const AppointmentList({Key? key, required this.patient}) : super(key: key);

  final Patient patient;

  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  Future<List<Appointment>> getPatientAppointments() async {
    print("RETRIEVING DATA");
    List<Appointment> appointments = await PatientsDAO.getPatientAppointments(
        widget.patient, Provider.of<DoctorNotifier>(context).token, context);
    print("DONE");
    return appointments;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.patient.name,
        ),
      ),
      body: FutureBuilder(
        future: getPatientAppointments(),
        builder: (context, AsyncSnapshot<List<Appointment>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError) {
            if (snapshot.data?.length == 0) {
              return Center(
                child: Text("NO HAY REGISTROS"),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                              "${snapshot.data![index].date.day}/${snapshot.data![index].date.month}/${snapshot.data![index].date.year}"),
                          subtitle:
                              Text("Notas: ${snapshot.data![index].info!}"),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
