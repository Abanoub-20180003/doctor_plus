import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class dbConstants {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference patientsRef =
      FirebaseFirestore.instance.collection('patients');

  static final CollectionReference drugsRef =
  FirebaseFirestore.instance.collection('drugs');

  static final CollectionReference Tests_TypesRef =
  FirebaseFirestore.instance.collection('Reports');

  static final CollectionReference organizationsRef =
  FirebaseFirestore.instance.collection('Organizations');

  static final CollectionReference patient_drugs_Ref =
  FirebaseFirestore.instance.collection('patientDrugs');

  static final CollectionReference doctorsRef =
  FirebaseFirestore.instance.collection('doctors');
  static final FirebaseAuth auth = FirebaseAuth.instance;
}
