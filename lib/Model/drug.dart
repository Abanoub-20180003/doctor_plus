import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/Model/doctor.dart';

class Drug {
  // ganeral info
  String? Id, name, com_name, description , doc_id;

  int? quantity ;
  Doctor? doctor;

  Timestamp?  Start_at, end_at, created_at,updated_at;

  Drug(){}

  Drug.withdata(
      {
          required String Id,
          required String name,
          required String com_name,
          required String description,
          required Timestamp Start_at,
          required Doctor? doctor,
          Timestamp? end_at,
          int? quantity,
          required Timestamp created_at,
          required Timestamp updated_at,
        }
      )
  {
    this.Id = Id;
    this.name = name;
    this.com_name = com_name;
    this.description = description;
    this.quantity = quantity;
    this.doctor = doctor;
    this.Start_at = Start_at;
    this.created_at = created_at;
    this.updated_at = updated_at;
    this.end_at = end_at;

  }
}
