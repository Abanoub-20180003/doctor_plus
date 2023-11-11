import 'package:cloud_firestore/cloud_firestore.dart';

class Organization {
  String? name, Id, location,doc_id;

  Timestamp? created_at , updated_at;
  Doctor_org Main_Doctor = Doctor_org();
  List<Doctor_org> doctors =[];
  List<Patient_org> patients=[];

  Organization(){}

  Organization.withdata({
    required String Id,
    required String name,
    required String location,
    required String doc_id,
    required Timestamp created_at,
    required Timestamp updated_at
}){
    this.Id = Id;
    this.name = name;
    this.location = location;
    this.doc_id = doc_id;
    this.created_at = created_at;
    this.updated_at = updated_at;


  }
}



class DoctorOrganization {
  late String docId;
  late String orgId;

  DoctorOrganization(this.docId, this.orgId);
}


class Doctor_org {
  late String id;
  late String name;
  late String email;

  Doctor_org(){}

  Doctor_org.withdata(this.id, this.name,this.email);
}



class Patient_org {
  late String id,name;

  Patient_org(this.id, this.name);
}