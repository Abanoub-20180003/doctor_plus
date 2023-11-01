import 'package:cloud_firestore/cloud_firestore.dart';

abstract class dbConstants {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference patientsRef =
      FirebaseFirestore.instance.collection('patients');

  static final CollectionReference drugsRef =
  FirebaseFirestore.instance.collection('drugs');
}
