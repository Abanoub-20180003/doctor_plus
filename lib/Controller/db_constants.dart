import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class dbConstants {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference patientsRef =
      FirebaseFirestore.instance.collection('patients');
  static final CollectionReference doctorsRef =
      FirebaseFirestore.instance.collection('doctors');
  static final FirebaseAuth auth = FirebaseAuth.instance;
}
