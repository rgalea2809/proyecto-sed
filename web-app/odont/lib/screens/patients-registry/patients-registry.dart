import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:odont/data/DAOs/patientsDao.dart';
import 'package:odont/data/changeNotifiers/doctorNotifier.dart';
import 'package:odont/data/data-models/patientModel.dart';
import 'package:provider/provider.dart';

class PatientsRegistry extends StatefulWidget {
  const PatientsRegistry({Key? key}) : super(key: key);

  @override
  _PatientsRegistryState createState() => _PatientsRegistryState();
}

class _PatientsRegistryState extends State<PatientsRegistry> {
  String selectedDate = "Fecha de Nacimiento";
  bool hasSelectedDate = false;

  String name = "";
  String lastName = "";
  DateTime birthDate = DateTime.now();
  String weigth = "";
  String sex = "";
  String email = "";
  String phone = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Registro de Pacientes"),
        ),
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxWidth: 600),
            margin: EdgeInsets.all(15),
            child: Column(
              children: [
                // Name
                TextField(
                  decoration: InputDecoration(label: Text("Nombre")),
                  onChanged: (text) {
                    name = text;
                  },
                ),
                // Lastname
                TextField(
                  decoration: InputDecoration(label: Text("Apellido")),
                  onChanged: (text) {
                    lastName = text;
                  },
                ),
                // BirthDate
                TextButton(
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now());

                    if (date != null) {
                      setState(() {
                        selectedDate = date.toString();
                        birthDate = date;
                      });
                    }
                  },
                  child: Text(selectedDate),
                ),
                // weigth
                TextField(
                  decoration: InputDecoration(label: Text("Peso (KG)")),
                  onChanged: (text) {
                    weigth = text;
                  },
                ),
                // Sex
                TextField(
                  decoration: InputDecoration(label: Text("Género")),
                  onChanged: (text) {
                    sex = text;
                  },
                ),
                // email
                TextField(
                  decoration:
                      InputDecoration(label: Text("Correo electronico")),
                  onChanged: (text) {
                    email = text;
                  },
                ),
                // phone
                TextField(
                  decoration: InputDecoration(label: Text("Telefono")),
                  onChanged: (text) {
                    phone = text;
                  },
                ),

                // submit
                ElevatedButton(
                  onPressed: () async {
                    Patient newPatient = Patient(
                      weight: double.parse(weigth),
                      name: name,
                      lastName: lastName,
                      email: email,
                      phone: phone,
                      medicalConditions: [],
                      sex: sex,
                      patientId: "",
                      birthDate: birthDate,
                    );
                    bool createdPatient = await PatientsDAO.createPatient(
                        newPatient,
                        Provider.of<DoctorNotifier>(context, listen: false)
                            .token,
                        context);
                    if (createdPatient) {
                      Fluttertoast.showToast(msg: "Paciente Creado");
                    } else {
                      Fluttertoast.showToast(msg: "Error Creando Paciente");
                    }
                  },
                  child: Text("CREAR PACIENTE"),
                ),
              ],
            ),
          ),
        ));
  }
}
