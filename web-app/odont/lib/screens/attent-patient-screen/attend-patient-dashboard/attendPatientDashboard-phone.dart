import 'package:flutter/material.dart';
import 'package:odont/data/DAOs/patientsDao.dart';
import 'package:odont/data/changeNotifiers/doctorNotifier.dart';
import 'package:odont/data/data-models/patientModel.dart';
import 'package:odont/data/data-models/treatmentModel.dart';
import 'package:provider/provider.dart';

class AttendPatientDashboardPhone extends StatefulWidget {
  const AttendPatientDashboardPhone(
      {Key? key, required this.patient, required this.onTextChanged})
      : super(key: key);
  final Patient patient;
  final Function onTextChanged;
  @override
  _AttendPatientDashboardPhoneState createState() =>
      _AttendPatientDashboardPhoneState();
}

//TODO: Add posting of data

class _AttendPatientDashboardPhoneState
    extends State<AttendPatientDashboardPhone> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 1000,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Paciente",
                                style: Theme.of(context).textTheme.overline,
                              ),
                              Text(
                                widget.patient.getFullName(),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                                "Edad: ${widget.patient.getPatientAge()} años.  "),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Flexible(
                            child: Text(
                              "Fecha de Nacimiento: ${widget.patient.birthDate.day}-${widget.patient.birthDate.month}-${widget.patient.birthDate.year}.",
                              maxLines: 3,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child:
                                Text("Peso: ${widget.patient.weight} lbs.  "),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Flexible(
                            child: Text(
                              "Sexo: ${widget.patient.sex}.",
                              maxLines: 3,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // medical Conditions
            Container(
              margin: EdgeInsets.all(10),
              child: Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text("Condiciones Medicas:"),
                      Container(
                        height: 150,
                        child: ListView.builder(
                          itemCount: widget.patient.medicalConditions.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(5),
                              child:
                                  Text(widget.patient.medicalConditions[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Informacion de cOnsulta
            Container(
              margin: EdgeInsets.all(10),
              child: Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text("Notas de la consulta actual: "),
                      Container(
                          height: 150,
                          child: TextField(
                            onChanged: (text) {
                              widget.onTextChanged(text);
                            },
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                          )),
                    ],
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
