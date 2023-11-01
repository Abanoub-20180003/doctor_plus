import 'package:doctor_plus/Controller/firestore_crud.dart';
import 'package:doctor_plus/Model/doctor.dart';
import 'package:flutter/material.dart';
//import 'package:hive_flutter/hive_flutter.dart';
import 'package:doctor_plus/View/Screens/LoginView/login.dart';
import 'package:doctor_plus/View/Screens/NewPatientFormView/new_patient_form.dart';
import 'package:doctor_plus/Model/patient.dart';
import 'package:doctor_plus/View/Screens/SearchView/view_search_patinets.dart';
import 'package:doctor_plus/View/Style/color_manager.dart';

class Home extends StatelessWidget {
  Doctor doctor = Doctor();
  Home(Doctor doctro, {super.key}) {
    // TODO: implement Home
    this.doctor = doctro;
  }

  final List<Patient> patientList = [];
  final ButtonStyle homeButtonsStyle = ElevatedButton.styleFrom(
      backgroundColor: ColorManager.grey,
      textStyle: const TextStyle(fontSize: 20),
      fixedSize: const Size(320, 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap);

  // local storage
  //final Box _boxLogin = Hive.box("login");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DoctorP+"),
        actions: [
          // log out button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
              ),
              child: IconButton(
                onPressed: () {
                  // local storage
                  //_boxLogin.clear();
                  //_boxLogin.put("loginStatus", false);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const Login();
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.logout_rounded),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome 🎉",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            Text(
              //local storage
              //_boxLogin.get("userName"),
              "Admin",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 10),
            // Search Button
            ElevatedButton(
                child: Text('Search...'),
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchBlock()));
                },
                style: homeButtonsStyle),
            const SizedBox(height: 10),
            // new patinet button
            ElevatedButton(
                child: Text('Add New Patient'),
                style: homeButtonsStyle,
                onPressed: () async {
                  // stroe retrun patient form the form
                  final newPatient = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => newPatientForm(
                                doctor: this.doctor,
                              )));
                  // store the new patient in the list of patients
                  patientList.add(newPatient);
                  print(patientList.length);
                }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
