import 'package:flutter/material.dart';
import 'package:odont/data/data-models/patientModel.dart';

class AttendPatientDashboardPhone extends StatefulWidget {
  const AttendPatientDashboardPhone({Key? key, required this.patient})
      : super(key: key);
  final Patient patient;
  @override
  _AttendPatientDashboardPhoneState createState() =>
      _AttendPatientDashboardPhoneState();
}

class _AttendPatientDashboardPhoneState
    extends State<AttendPatientDashboardPhone> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 600,
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
          ],
        ),
      ),
    );
  }
}
