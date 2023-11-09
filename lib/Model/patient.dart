import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/Model/drug.dart';
import 'package:doctor_plus/Model/patient_drug.dart';
import 'package:doctor_plus/Model/patient_medical_test.dart';
import 'package:doctor_plus/Model/patient_visit.dart';

class Patient {
  // ganeral info
  String? no,
      rank,
      name,
      birthOfDate,
      maritalStatus,
      gander,
      occupation,
      specialHabit,
      blood,
      docId,
      age,
      userId;

  Timestamp?  Start_at, created_at,updated_at;
  // address
  String? address, telHome, cellPhone;
  // boolean if patinet need to hospitalize
  bool? hospitalized;
  //list of patient visits
  List<PatientVisit>? visits;
  // organization lint
  String? organizationId;
  // patinet medical tests
  List<PatientMedicalTest>? medicaltests;
  // patinet drugs
  List<Drug>? drugs;
}
