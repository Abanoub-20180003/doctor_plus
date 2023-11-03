import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/Model/doctor.dart';
import 'package:doctor_plus/Model/drug.dart';
import 'package:doctor_plus/Model/patient.dart';
import 'package:doctor_plus/View/Layout/components/constants.dart';
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




  Future<void> addPatient(Patient patient) async {
    dbConstants.patientsRef
        .add({
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
        .doc(patient.docId)
        .delete()
        .then((value) => print("Patinet deleted"))
        .catchError((error) => print("Failed to delete the patinet: $error"));
  }

  Future<void> updatePatinet(Patient patient) async {
    // set fun removs all old values and rewrite it
    dbConstants.patientsRef
        .doc(patient.docId)
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

  Future<List<Drug>> getDrugs() async{
    List<Drug> Drugs = [];
    await dbConstants.drugsRef.get().then((value) => {
      value.docs.forEach((element) {
        Drugs.add(_mapDrugFromDoc(element));
        element.data();
      })

    });
    return Drugs;
  }


  Future<List<Patient>> getPatients() async{
    List<Patient> patinets = [];
    await dbConstants.patientsRef.get().then((value) => {
          value.docs.forEach((element) {
            patinets.add(_mapPatinetFromDoc(element));
            element.data();
          })

        });
    return patinets;

  }







  Future<void> getDocById({
    required String doctorId,
  }) async {


        try {
          var querySnapshot = await FirebaseFirestore.instance.collection('doctors').where('id', isEqualTo: doctorId).limit(1).get();
          if (querySnapshot.docs.isNotEmpty) {
            // Assuming there's only one user with the specified id
            DocumentSnapshot userDoc = querySnapshot.docs.first;
            doctor_profile =  _mapDoctorFromDoc(userDoc);
            print("===============================l1 ==============================================================");
          } else {
            // User with the specified id not found
            print("==================================l2===========================================================");
            doctor_profile = Doctor();
          }
        } catch (e) {
          print("Error fetching user: $e");
          doctor_profile = Doctor();
          print("====================================l3=========================================================");
        }

  }


  Future<void> updateDoctor(Doctor doc) async {
    try {
      await FirebaseFirestore.instance.collection('doctors').doc(doc.id).update({
        'name': doc.name,
      });
      print("Doctor updated successfully");
    } catch (error) {
      print("Failed to update the doctor: $error");
    }
  }



















 // -----------------------------------------
  Future<bool> addDrug(Drug drug) async {
    try{
    dbConstants.drugsRef
        .add({
      'com_name': drug.com_name,
      'description': drug.description,
      'name': drug.name,

    });
    return true;
  } catch (error) {
  print("Failed to add the Medicine: $error");
  return false;
  }
  }





  Future<bool> deleteDrug(String Id) async {
    try {
      dbConstants.drugsRef
          .doc(Id)
          .delete();
      return true;
    }catch(error)
    {
      return false;
    }
  }

  Patient _mapPatinetFromDoc(DocumentSnapshot doc) {
    Patient p = Patient();
    p.docId = doc.id.toString();
    p.no = doc['no'].toString();
    p.rank = doc['rank'].toString();
    p.name = doc['name'];
    p.birthOfDate = doc['birthOfDate'].toString();
    p.maritalStatus = doc['maritalStatus'].toString();
    p.gander = doc['gander'].toString();
    p.occupation = doc['occupation'].toString();
    p.specialHabit = doc['specialHabit'].toString();
    return p;
  }


  Doctor _mapDoctorFromDoc(DocumentSnapshot doc) {
    Doctor p = Doctor();
    p.id = doc.id.toString();
    p.name = doc['name'].toString();
    p.email = doc['email'].toString();
    p.image = doc['image'].toString();
    // p.email = doc['email'].toString();
    // p.password = doc['password'].toString();
    //p.organizationId = doc['organizationId'];

    return p;
  }


  Drug _mapDrugFromDoc(DocumentSnapshot doc) {
    Drug p = Drug();
    p.Id = doc.id;
    p.com_name = doc['com_name'];
    p.description = doc['description'];
    p.name = doc['name'];

    return p;
  }
}
