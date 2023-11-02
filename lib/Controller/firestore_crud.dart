import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/Model/patient.dart';
import 'package:doctor_plus/Model/doctor.dart';
import 'package:doctor_plus/View/Screens/NewPatientFormView/new_patient_form.dart';
import 'db_constants.dart';

class firestroeCRUD {
  Future<void> addDocotr(
      String name, String email, String pass, String id) async {
    dbConstants.doctorsRef
        .add({'email': email, 'id': id, 'name': name, 'password': pass})
        .then((value) => print("Doctor Added"))
        .catchError((error) => print("Failed to add the doctor: $error"));
  }

  // Doctor getDoctor(String email) {
  //   Doctor doctor = Doctor();
  //   doctor.email = email;
  //   doctor.id = id;
  //   doctor.name = name;
  //   doctor.password = pass;

  //   return doctor;
  // }

  Future<void> addPatient(Patient patient) async {
    dbConstants.patientsRef
        .add({
          'userId': patient.doctorId,
          'no': patient.no,
          'rank': patient.rank,
          'name': patient.name,
          'birthOfDate': patient.birthOfDate,
          'maritalStatus': patient.maritalStatus,
          'gander': patient.gander,
          'occupation': patient.occupation,
          'specialHabit': patient.specialHabit
        })
        .then((value) => print("Patinet Added"))
        .catchError((error) => print("Failed to add the patinet: $error"));
  }

  Future<void> deletePatient(Patient patient) async {
    dbConstants.patientsRef
        .doc(patient.patientId)
        .delete()
        .then((value) => print("Patinet deleted"))
        .catchError((error) => print("Failed to delete the patinet: $error"));
  }

  Future<void> updatePatinet(Patient patient) async {
    // set fun removs all old values and rewrite it
    dbConstants.patientsRef
        .doc(patient.patientId)
        .set({
          'no': patient.no,
          'rank': patient.rank,
          'name': patient.name,
          'birthOfDate': patient.birthOfDate,
          'maritalStatus': patient.maritalStatus,
          'gander': patient.gander,
          'occupation': patient.occupation,
          'specialHabit': patient.specialHabit
        })
        .then((value) => print("Patinet updated"))
        .catchError((error) => print("Failed to update the patinet: $error"));
  }

  List<Patient> getPatients() {
    List<Patient> patinets = [];
    dbConstants.patientsRef.get().then((value) => {
          value.docs.forEach((element) {
            patinets.add(_mapPatinetFromDoc(element));
            element.data();
          })
        });
    return patinets;
  }

  Patient _mapPatinetFromDoc(DocumentSnapshot doc) {
    Patient p = Patient();
    p.patientId = doc.id.toString();
    p.no = doc['no'];
    p.rank = doc['rank'];
    p.name = doc['name'];
    p.birthOfDate = doc['birthOfDate'];
    p.maritalStatus = doc['maritalStatus'];
    // gender
    p.gander = doc['gander'];
    p.occupation = doc['occupation'];
    p.specialHabit = doc['specialHabit'];
    return p;
  }
}
