

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/Model/doctor.dart';
import 'package:doctor_plus/Model/drug.dart';
import 'package:doctor_plus/Model/medical_test_type.dart';
import 'package:doctor_plus/Model/patient.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';
import 'package:doctor_plus/View/Layout/components/constants.dart';
import '../Model/organization.dart';
import 'db_constants.dart';

class firestroeCRUD {

  Future<void> addDocotr(
      String name, String email, String pass, String id) async {
    dbConstants.doctorsRef
        .add({'email': email, 'id': id, 'name': name, 'password': pass,'image':"2.png"})
        .then((value) => print("Doctor Added"))
        .catchError((error) => print("Failed to add the doctor: $error"));
  }




  Future<void> addPatient(Patient patient) async {

    final DocumentReference patientRef = dbConstants.patientsRef.doc();
    String patientId = patientRef.id; // This is a unique string identifier
     int uniqueIntegerId = patientId.hashCode;

    dbConstants.patientsRef
        .add({
          'no': uniqueIntegerId,
          'rank': patient.rank,
          'name': patient.name,
          'doc_added_id': doctor_profile.id,
          'org_id': patient.organizationId,
          'birthOfDate': patient.birthOfDate,
          'maritalStatus': patient.maritalStatus,
          'gander': patient.gander,
          'blood':  patient.blood,
          'occupation': patient.occupation,
          'specialHabit': patient.specialHabit,
          'address':patient.address,
          'phone':patient.cellPhone,
          'tel_home':patient.telHome,
          'Start_at':convert_date_to_time(DateTime.now()),
          'created_at':convert_date_to_time(DateTime.now()),
          'updated_at':convert_date_to_time(DateTime.now()),
        })
        .then((DocumentReference docRef) async {
           // patient_drugs_Ref
              for(Drug d in patient.drugs!)
                {
                  print("Patient Added with ID: ${docRef.id}");
                  await add_drugs_Patient(docRef.id,d);
                }
       })
        .catchError((error) => print("Failed to add the patinet: $error"));
  }


  Future<void> add_drugs_Patient(String patient_id,Drug drug) async {

    dbConstants.patient_drugs_Ref
        .add({
      'doc_id': doctor_profile.id,
      'patient_id': patient_id,
      'drug_id': drug.Id,
      'quantity_per_day': drug.quantity,
      'start_at': drug.Start_at,
      'end_at': drug.end_at,
      'created_at': convert_date_to_time(DateTime.now()),
      'updated_at': convert_date_to_time(DateTime.now()),

    }).then((DocumentReference docRef) {

      print("Added with ID:");

    })
        .catchError((error) => print("Failed to add the Drug for patinet: $error"));

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




  Future<Doctor?> getDoc_By_Column_Id({
    required String doctorId,
  }) async {


    try {
      var querySnapshot = await FirebaseFirestore.instance.collection('doctors').where('id', isEqualTo: doctorId).limit(1).get();
      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one user with the specified id
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        return _mapDoctorFromDoc(userDoc);
        print("===============================l1 ==============================================================");
      } else {
        // User with the specified id not found
        print("==================================l2===========================================================");
        return Doctor();
      }
    } catch (e) {
      print("Error fetching user: $e");
      return Doctor();
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


    p.doc_added_Id = doc['doc_added_id'];

    p.organizationId = doc['org_id'];


    p.address = doc['address'];
    p.cellPhone = doc['phone'];
    p.telHome = doc['tel_home'];


    p.created_at = doc['created_at'];
    p.updated_at = doc['updated_at'];
    return p;
  }


  Doctor _mapDoctorFromDoc(DocumentSnapshot doc) {
    Doctor p = Doctor();
    p.id = doc['id'].toString();
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


  Medical_Test_type _mapTests_TypesFromDoc(DocumentSnapshot doc) {
    Medical_Test_type p = Medical_Test_type.Get(
      id:doc.id,
      name:doc['name'] ,
      doc_id: doc['doc_id'],
      description: doc['description'],
      normal_result_low: doc['normal_result_low'],
      normal_result_high:doc['normal_result_high'] ,
      waiting_date:doc['waiting_date'].toString(),
      created_at: doc['created_at'],
      updated_at:doc['updated_at'] ,
    );
    return p;
  }





  //-------------------------- Organizations -----------------------------------
//
// // Function to add an organization
//   Future<bool> addOrganization(String organizationName, String organizationDescription) async {
//     // Get the current user's UID
//
//     String? uid = doctor_profile?.id;
//     if (uid != null) {
//       // Reference the user's organizations sub-collection
//       CollectionReference userOrganizations = FirebaseFirestore.instance.collection('doctors').doc(uid).collection('Organizations');
//
//       // Add a new organization document with the user's UID as a field
//       DocumentReference organizationRef = await userOrganizations.add({
//         'name': organizationName,
//         'description': organizationDescription,
//         'addedByUid': uid, // Store the UID of the user who added the organization
//       });
//
//       print('Organization added with ID: ${organizationRef.id}');
//       return true;
//     } else {
//       print('User is not authenticated');
//       return false;
//     }
//   }
//
//


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



  Future<Organization> getOrganizationby_id(String org_id) async {
    try{
      DocumentSnapshot orgDocument = await FirebaseFirestore.instance
          .collection('Organizations')
          .doc(org_id)
          .get();

      print(orgDocument);
      if (orgDocument.exists) {
        Organization org = Organization.withdata(
          Id: orgDocument.id,
          name: orgDocument['name'],
          location: orgDocument['location'],
          doc_id: orgDocument['doc_id'],
          created_at: orgDocument['created_at'],
          updated_at: orgDocument['updated_at'],

        );
        return org;
      }
      return Organization();

    }catch(error)
    {
      print(error.toString());
      return Organization();
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
          .collection('patients')
          .where('org_id', isEqualTo: org_id.Id)
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
      if(userDoc['id'] == org_id.doc_id)
        {
          org_id.Main_Doctor = Doctor_org.withdata(
            userDoc['id'],
            userDoc['name'],
            userDoc['email'],
          );
        }
      else
        {
          doctors.add(Doctor_org.withdata(
            userDoc['id'],
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
        if (doc.exists) {
          patients.add(Patient_org(
            doc.id,
            doc['name'],
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


        patient.org =  await getOrganizationby_id(patient.organizationId!);

        patient.doc = await getDoc_By_Column_Id(doctorId: patient.doc_added_Id!);

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
         print("----------------======================================l2 l2 l2 l2 l2 4============================------------------------------");
          String doc_id = patientDrugDoc['doc_id'];
          print("${doc_id}");
          print("----------------======================================l2 l2 l2 l2 l2 4============================------------------------------");
          Doctor? doctor = await getDoc_By_Column_Id(doctorId: doc_id);
          print("===_>>>>>>>>>> ${doctor.toString()}");
           print("===_>>>>>>>>>> ${ drugDoc['name'].toString()}");



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



  Future<Patient?> getPatient_byId_WithDrugs(String patient_id) async {
    try {
      DocumentSnapshot patientQuery = await FirebaseFirestore.instance.collection('patients').doc(patient_id).get();




      Patient patient2 = _mapPatinetFromDoc(patientQuery);


      patient2.org =  await getOrganizationby_id(patient2.organizationId!);

      patient2.doc = await getDoc_By_Column_Id(doctorId: patient2.doc_added_Id!);

      patient2.drugs = await getDrugsForPatient(patient_id);


      return patient2;
    } catch (error) {
      print("Error fetching patients with drugs: $error");
      return Patient();
    }
  }







  Future<Doctor?> getDoc_By_Column_email({
    required String Doctor_email,
  }) async {

    try {
      var querySnapshot = await FirebaseFirestore.instance.collection('doctors').where('email', isEqualTo: Doctor_email).limit(1).get();
      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one user with the specified id
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        return _mapDoctorFromDoc(userDoc);
        print("===============================l1 ==============================================================");
      } else {
        return Doctor();
      }
    } catch (e) {
      print("Error fetching user: $e");
      return Doctor();
    }

  }


  Future<bool> Check_if_doctor_not_on_organization(String org_id,String doc_id) async {
    try {

      var querySnapshot2 = await FirebaseFirestore.instance.collection('DoctorOrganization').where('doc_id', isEqualTo: doc_id).where('org_id', isEqualTo: org_id).limit(1).get();
      print(querySnapshot2.size);
      print(org_id);
      print(doc_id);
      if (querySnapshot2.docs.length == 0) {

        return true;
      }
      return false;

    } catch (error) {
      print("Error fetching patients with drugs: $error");
      return false;
    }
  }



  Future<bool> Assign_Doctor_to_org(String org_id,String doc_id) async {
    try {

          FirebaseFirestore.instance.collection('DoctorOrganization').add({
            'doc_id':doc_id,
            'org_id':org_id
          });
          return true;

    } catch (error) {
      print("Error fetching patients with drugs: $error");
      return false;
    }
  }


  Future<bool> add_new_organization(Organization org) async {
    try{
      dbConstants.organizationsRef
          .add({
        'name': org.name,
        'location': org.location,
        'doc_id': doctor_profile.id,
        'created_at': convert_date_to_time(DateTime.now()),
        'updated_at': convert_date_to_time(DateTime.now()),

      }).then((DocumentReference OrganizationRef) async {

          print("Organization Added with ID: ${OrganizationRef.id}");
          await Assign_Doctor_to_org(OrganizationRef.id,doctor_profile.id!);

      }).catchError((error) => print("Failed to add the Organization: $error"));

      return true;
    } catch (error) {
      print("Failed to add the Medicine: $error");
      return false;
    }
  }

// ------------------------------------------------------- Medical Tests Types ---------------------------------------------

  Future<List<Medical_Test_type>> Get_Medical_Test_Types() async{
    List<Medical_Test_type> types = [];
    await dbConstants.Tests_TypesRef.get().then((value) => {
      value.docs.forEach((element) {
        types.add(_mapTests_TypesFromDoc(element));
        element.data();
      })

    });
    return types;
  }


  Future<bool> Add_Medical_Test_Type(Medical_Test_type Test_Type) async {
    try{
      dbConstants.Tests_TypesRef
          .add({
        'name': Test_Type.name,
        'description': Test_Type.description,
        'normal_result_low': Test_Type.normal_result_low,
        'normal_result_high': Test_Type.normal_result_high,
        'waiting_date': Test_Type.waiting_date,
        'doc_id': doctor_profile.id!,
        'created_at': convert_date_to_time(DateTime.now()),
        'updated_at': convert_date_to_time(DateTime.now()),

      });
      return true;
    } catch (error) {
      print("Failed to add the Test Type: $error");
      return false;
    }
  }

  Future<bool> Delete_Medical_Test(String Id) async {
    try {
      dbConstants.Tests_TypesRef
          .doc(Id)
          .delete();
      return true;
    }catch(error)
    {
      return false;
    }
  }



}
