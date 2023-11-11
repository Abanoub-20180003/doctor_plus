import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_plus/View/Layout/components/components.dart';
import 'package:doctor_plus/View/Widgets/patient_card_title.dart';
import 'package:flutter/cupertino.dart';

class Medical_Test_type {
  late String? id, name , description , normal_result_low , normal_result_high , doc_id , take_time  ;
  Timestamp? waiting_date;
  late Timestamp?  created_at , updated_at;

  Medical_Test_type.no_data(){}

  Medical_Test_type({
    required String id ,
    required String name,
    required String description,
    required String normal_result_low,
    required String normal_result_high,
    required String doc_id,
    required String waiting_date,
    required Timestamp created_at,
    required Timestamp updated_at,

}){
    this.id = id;
    this.name= name;
    this.description= description;
    this.normal_result_low = normal_result_low;
    this.normal_result_high = normal_result_high;
    this.doc_id =doc_id;
    this.waiting_date = convert_string_to_time(waiting_date);
    this.created_at = created_at;
    this.updated_at = updated_at;

  }


  Medical_Test_type.Get({
    required String id ,
    required String name,
    required String description,
    required String normal_result_low,
    required String normal_result_high,
    required String doc_id,
    required String waiting_date,
    required Timestamp created_at,
    required Timestamp updated_at,

  }){
    this.id = id;
    this.name= name;
    this.description= description;
    this.normal_result_low = normal_result_low;
    this.normal_result_high = normal_result_high;
    this.doc_id =doc_id;
    this.take_time = waiting_date.toString();
    this.created_at = created_at;
    this.updated_at = updated_at;

  }
}
