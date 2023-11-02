import 'package:flutter/cupertino.dart';

class MedicalTest {
  late String? id, name , type , patient_id , organization_id , doc_id, result  ;
  late bool result_bool;
  late DateTime? date, created_at , updated_at;

   MedicalTest({
    required String id ,
    required String name,
    required String type,
    required String result,
    required bool result_bool,
    required String patient_id,
    required String organization_id,
    required String doc_id,
    required DateTime date,
    required DateTime created_at,
    required DateTime updated_at,

}){
    this.id = id;
    this.name= name;
    this.type= type;
    this.result = result;
    this.result_bool = result_bool;
    this.patient_id = patient_id;
    this.organization_id = organization_id;
    this.doc_id =doc_id;
    this.date = date;
    this.created_at = created_at;
    this.updated_at = updated_at;

  }
}
