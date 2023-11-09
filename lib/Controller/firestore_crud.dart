import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/Model/doctor.dart';
import 'package:doctor_plus/Model/drug.dart';
import 'package:doctor_plus/Model/patient.dart';
import 'package:doctor_plus/View/Layout/components/constants.dart';
import 'package:doctor_plus/View/Screens/NewPatientFormView/new_patient_form.dart';
import '../Model/organization.dart';
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
        .then((DocumentReference docRef) {

              print("Patient Added with ID: ${docRef.id}");
       })
        .catchError((error) => print("Failed to add the patinet: $error"));
  }


  // Future<void> add_drugs_Patient(int patient_id) async {
  //
  //   for (Drug drug in drugs_added_patient)
  //     {
  //       var querySnapshot = await FirebaseFirestore.instance.collection('patientDrugs').add({
  //
  //       })  .then((DocumentReference docRef) {
  //
  //         print("Patient Added with ID: ${docRef.id}");
  //     }
  //
  //       .catchError((error) => print("Failed to add the patinet: $error"));
  // }
  //



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

  //
  // Future<List<Patient>> getPatients() async{
  //   List<Patient> patinets = [];
  //   await dbConstants.patientsRef.get().then((value) => {
  //         value.docs.forEach((element) {
  //           patinets.add(_mapPatinetFromDoc(element));
  //           element.data();
  //         })
  //
  //       });
  //   return patinets;
  //
  // }







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



  Future<Doctor?> get_Doc_ById({
    required String doctorId,
  }) async {


    try {
      var querySnapshot = await FirebaseFirestore.instance.collection('doctors').doc(doctorId).get();
      if (querySnapshot.exists) {
        // Assuming there's only one user with the specified id
        DocumentSnapshot userDoc = querySnapshot;
        return _mapDoctorFromDoc(userDoc);
        print("===============================l1 ==============================================================");
      } else {
        // User with the specified id not found
        print("==================================l2===========================================================");
       return null;
      }
    } catch (e) {
      print("Error fetching user: $e");
      return null;
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
    String birthdateString = doc['birthOfDate'].toString(); // Replace with the actual date string
    DateTime birthdate = DateTime.parse(birthdateString);
    print("--------------------------------------");
    print(birthdate);
    print("----------------------------------------");
    DateTime now = DateTime.now();
    Duration difference = now.difference(birthdate);
    int age = (difference.inDays ~/ 365.25).toInt();

    p.age = age.toString();
    p.docId = doc.id.toString();
    p.no = doc['no'].toString();
    p.rank = doc['rank'].toString();
    p.name = doc['name'];
    p.birthOfDate = doc['birthOfDate'].toString();
    p.maritalStatus = doc['maritalStatus'].toString();
    p.gander = doc['gander'].toString();
    p.occupation = doc['occupation'].toString();
    p.specialHabit = doc['specialHabit'].toString();
    p.blood = doc['blood'].toString();
    p.Start_at = doc['Start_at'];

    p.address = doc['address'];
    p.cellPhone = doc['phone'];
    p.telHome = doc['tel_home'];


    p.created_at = doc['created_at'];
    p.updated_at = doc['updated_at'];
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






  //-------------------------- Organizations -----------------------------------

// Function to add an organization
  Future<bool> addOrganization(String organizationName, String organizationDescription) async {
    // Get the current user's UID

    String? uid = doctor_profile?.id;
    if (uid != null) {
      // Reference the user's organizations sub-collection
      CollectionReference userOrganizations = FirebaseFirestore.instance.collection('doctors').doc(uid).collection('Organizations');

      // Add a new organization document with the user's UID as a field
      DocumentReference organizationRef = await userOrganizations.add({
        'name': organizationName,
        'description': organizationDescription,
        'addedByUid': uid, // Store the UID of the user who added the organization
      });

      print('Organization added with ID: ${organizationRef.id}');
      return true;
    } else {
      print('User is not authenticated');
      return false;
    }
  }




  Future<List<Organization>> getDoctorOrganizations() async {
    try{
    List<Organization> organizations = [];
    var doctorId = doctor_profile.id;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('DoctorOrganization')
        .where('doc_id', isEqualTo: doctorId)
        .get();
    print("-----------=============-------------------------");
    print(doctor_profile.id);
    print("-----------=============-------------------------");
      print(querySnapshot.size);
    print("-----------=============-------------------------");
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      String orgId = doc['org_id'];
        print(doc['org_id']);

      // Retrieve the organization document based on orgId
      DocumentSnapshot orgDocument = await FirebaseFirestore.instance
          .collection('Organizations')
          .doc(orgId)
          .get();

      print(orgDocument);
      if (orgDocument.exists) {
        organizations.add(Organization.withdata(
            Id:orgDocument.id,
            name:orgDocument['name'],
            location:orgDocument['location'],
            doc_id:orgDocument['doc_id'],
            created_at:orgDocument['created_at'],
            updated_at:orgDocument['updated_at'],

        ));
      }
    }

    return organizations;
    }catch(error)
    {
      print(error.toString());
      return [];
    }
  }







  Future<Organization> getOrganization_details(Organization org_id) async {
    try{
      print(org_id.Id);
     // Organization organizations = new Organization();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('DoctorOrganization')
          .where('org_id', isEqualTo: org_id.Id)
          .get();

      org_id.doctors = await getOrganization_doctors(querySnapshot,org_id);

      QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
          .collection('PatientOrganization')
          .where('organization_id', isEqualTo: org_id.Id)
          .get();

      org_id.patients = await getOrganization_patients(querySnapshot2);
      return org_id;

    }catch(error)
    {
      print(error.toString());
      return Organization();
    }
  }




  Future<List<Doctor_org>> getOrganization_doctors(querySnapshot,Organization org_id) async {
    List<Doctor_org> doctors = [];
    try{

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        String doc_id = doc['doc_id'];
        // print('------------------------------------');
        // print(doc_id);
        // print('------------------------------------');


        // Retrieve the organization document based on orgId
        var querySnapshot = await FirebaseFirestore.instance.collection('doctors').where('id', isEqualTo: doc_id).limit(1).get();


        if(querySnapshot.docs.isNotEmpty)
  {
    DocumentSnapshot userDoc = querySnapshot.docs.first;
    print('------------------------------------');
    print(userDoc.toString());
    print(userDoc.id);
    print(userDoc.data().toString());
    print('------------------------------------');
    if (userDoc.exists) {
      if(userDoc.id == org_id.doc_id)
        {
          org_id.Main_Doctor = Doctor_org.withdata(
            userDoc.id,
            userDoc['name'],
            userDoc['email'],
          );
        }
      else
        {
          doctors.add(Doctor_org.withdata(
            userDoc.id,
            userDoc['name'],
            userDoc['email'],
          ));
        }


    }
  }
 }
      return doctors;
    }catch(error)
    {
      print('------------------------------------No0-No');
      print(error.toString());
      return [];
    }
  }



  Future<List<Patient_org>> getOrganization_patients(querySnapshot) async {
    List<Patient_org> patients = [];
    try{

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        String patient_id = doc['patient_id'];
        print(patient_id);

        // Retrieve the organization document based on orgId
        DocumentSnapshot orgDocument = await FirebaseFirestore.instance
            .collection('patients')
            .doc(patient_id)
            .get();

        print(orgDocument);
        if (orgDocument.exists) {
          patients.add(Patient_org(
            orgDocument.id,
            orgDocument['name'],
          ));
        }
      }

      return patients;
    }catch(error)
    {
      print(error.toString());
      return [];
    }
  }











  Future<List<Patient>> getAllPatientsWithDrugs() async {
    try {
      QuerySnapshot patientQuery = await FirebaseFirestore.instance.collection('patients').get();

      List<Patient> patients = [];

      for (QueryDocumentSnapshot patientDoc in patientQuery.docs) {
        Patient patient = _mapPatinetFromDoc(patientDoc);
        print("000000000000000000000000000000000000000");
        print(patientDoc.id);
        print("000000000000000000000000000000000000000");
        patient.drugs = await getDrugsForPatient(patientDoc.id);
        patients.add(patient);
      }

      return patients;
    } catch (error) {
      print("Error fetching patients with drugs: $error");
      return [];
    }
  }

  Future<List<Drug>> getDrugsForPatient(String patientId) async {
    try {
      QuerySnapshot patientDrugQuery = await FirebaseFirestore.instance
          .collection('patientDrugs')
          .where('patient_id', isEqualTo: patientId)
          .get();

      List<Drug> drugs = [];

      print(patientDrugQuery.docs.length);


      for (QueryDocumentSnapshot patientDrugDoc in patientDrugQuery.docs) {
        String drugId = patientDrugDoc['drug_id'];

        print("${patientDrugDoc['drug_id']}");

        DocumentSnapshot drugDoc =
        await FirebaseFirestore.instance.collection('drugs').doc(drugId).get();

        if (drugDoc.exists) {
       //   print("----------------======================================l2 l2 l2 l2 l2 4============================------------------------------");
          String doc_id = patientDrugDoc['doc_id'];
        //  print("${doc_id}");
        //  print("----------------======================================l2 l2 l2 l2 l2 4============================------------------------------");
          Doctor? doctor = await get_Doc_ById(doctorId: doc_id);
          // print("===_>>>>>>>>>> ${doctor.toString()}");
          // print("===_>>>>>>>>>> ${ drugDoc['name'].toString()}");
          // print("===_>>>>>>>>>> ${drugDoc['com_name'].toString()}");
          // print("===_>>>>>>>>>> ${drugDoc['description'].toString()}");
          // print("===_>>>>>>>>>> ${patientDrugDoc['start_at'].toString()}");
          // print("===_>>>>>>>>>> ${patientDrugDoc['end_at'].toString()}");
          // print("===_>>>>>>>>>> ${patientDrugDoc['created_at'].toString()}");
          // print("===_>>>>>>>>>> ${patientDrugDoc['updated_at'].toString()}");


          Drug drug = Drug.withdata(
              Id: drugDoc.id,
              name: drugDoc['name'],
              com_name: drugDoc['com_name'],
              description: drugDoc['description'],
              Start_at: patientDrugDoc['start_at'],
              end_at:patientDrugDoc['end_at'],
              doctor: doctor,
              created_at: patientDrugDoc['created_at'],
              updated_at: patientDrugDoc['updated_at']
          );

          drugs.add(drug);
        }
      }

      return drugs;
    } catch (error) {
      print("Error fetching drugs for patient: $error");
      return [];
    }
  }











}
