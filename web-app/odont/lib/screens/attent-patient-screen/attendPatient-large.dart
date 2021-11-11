import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:odont/data/DAOs/patientsDao.dart';
import 'package:odont/data/changeNotifiers/doctorNotifier.dart';
import 'package:odont/data/data-models/patientModel.dart';
import 'package:odont/screens/attent-patient-screen/attend-patient-dashboard/attendPatientDashboard.dart';
import 'package:provider/provider.dart';

class AttendPatientDesktop extends StatefulWidget {
  @override
  _AttendPatientDesktopState createState() => _AttendPatientDesktopState();
}

class _AttendPatientDesktopState extends State<AttendPatientDesktop> {
  String? currentSearch;

  Future<void> showPatientSelectionDialog(Patient patient) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Ha seleccionado el Paciente Correcto?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'Nombre: ',
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: '${patient.getFullName()}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Telefono: ',
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: '${patient.phone}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Email: ',
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: '${patient.email}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Edad: ',
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: '${patient.getPatientAge()}',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendPatientDashboard(
                      patient: patient,
                    ),
                  ),
                );
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  bool hasSearchedPatient() {
    if (currentSearch == null || currentSearch!.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
            maxWidth: 600,
            maxHeight: MediaQuery.of(context).size.height * 0.80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(1, 1), blurRadius: 5)
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: EdgeInsets.all(15),
              child: TextField(
                onSubmitted: (search) {
                  setState(() {
                    currentSearch = search;
                  });
                },
                scrollPadding: EdgeInsets.all(5),
                decoration: InputDecoration(
                  hintText: "Nombre de Paciente",
                  icon: Icon(Icons.search),
                  isDense: true,
                  contentPadding: EdgeInsets.all(0),
                ),
              ),
            ),
            Flexible(
              child: hasSearchedPatient()
                  ? FutureBuilder(
                      future: PatientsDAO.getMatchingPatients(
                          currentSearch!,
                          Provider.of<DoctorNotifier>(context)
                              .currentDoctor!
                              .token),
                      builder:
                          (context, AsyncSnapshot<List<Patient>> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Error Retrieving Patients, Contact your Provider",
                            ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.data!.length > 0) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return PatientSelectionCard(
                                    patient: snapshot.data![index],
                                    onTap: () {
                                      showPatientSelectionDialog(
                                          snapshot.data![index]);
                                    },
                                  );
                                },
                              ),
                            );
                          } else {
                            return Center(
                              child: Text("No Match"),
                            );
                          }
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  : Center(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          "Ingrese el Nombre del paciente, su Correo o su numero de Telefono para iniciar la búsqueda",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class PatientSelectionCard extends StatelessWidget {
  const PatientSelectionCard(
      {Key? key, required this.patient, required this.onTap})
      : super(key: key);

  final Patient patient;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () => this.onTap(),
        child: Container(
            margin: EdgeInsets.all(15), child: Text(patient.getFullName())),
      ),
    );
  }
}
