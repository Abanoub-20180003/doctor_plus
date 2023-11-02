

import 'package:doctor_plus/Model/doctor.dart';
import 'package:doctor_plus/View/Layout/colors.dart';
import 'package:doctor_plus/View/Layout/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:doctor_plus/View/Screens/LoginView/login.dart';
import 'package:doctor_plus/View/Screens/NewPatientFormView/new_patient_form.dart';
import 'package:doctor_plus/Model/patient.dart';
import 'package:doctor_plus/View/Screens/SearchView/view_search_patinets.dart';
import 'package:doctor_plus/View/Style/color_manager.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class Home extends StatelessWidget {


  final _pageController = PageController(initialPage: 0);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 0);

  int maxCount = 5;



  /// widget list
  final List<Widget> bottomBarPages = [
    // home_page(context),

  ];


  Home({super.key});
  final List<Patient> patientList = [];
  final ButtonStyle homeButtonsStyle = ElevatedButton.styleFrom(
      backgroundColor: defaultColor,
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
      // appBar: AppBar(
      //   title: const Text("DoctorP+"),
      //   actions: [
      //     // log out button
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: DecoratedBox(
      //         decoration: BoxDecoration(
      //           shape: BoxShape.circle,
      //           border: Border.all(color: Colors.white),
      //         ),
      //         child: IconButton(
      //           onPressed: () {
      //             // local storage
      //             //_boxLogin.clear();
      //             //_boxLogin.put("loginStatus", false);
      //
      //             Navigator.pushReplacement(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) {
      //                   return const Login();
      //                 },
      //               ),
      //             );
      //           },
      //           icon: const Icon(Icons.logout_rounded),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      body:   Container(
      color: Colors.white,
      child: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome 🎉",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 3),
            Text(
              //local storage
              //_boxLogin.get("userName"),
              "${doctor_con.email}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

            ),
            const SizedBox(height: 15),
            // Search Button
            ElevatedButton(
                style: homeButtonsStyle,
                child: Text('Search...',style: TextStyle(color:secondColor),),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchBlock()));
                },
                ),
            const SizedBox(height: 10),
            // new patinet button
            ElevatedButton(
                child: Text('Add New Patient',style: TextStyle(color:secondColor),),
                style: homeButtonsStyle,
                onPressed: () async {
                  // stroe retrun patient form the form
                  final newPatient = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => newPatientForm()));
                  // store the new patient in the list of patients
                  patientList.add(newPatient);
                  print(patientList.length);
                }),
            const SizedBox(height: 10),
          ],
        ),
      ),
    )
    );
  }
}
