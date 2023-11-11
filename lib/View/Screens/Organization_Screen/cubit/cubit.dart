

import 'package:doctor_plus/Controller/firestore_crud.dart';
import 'package:doctor_plus/Model/drug.dart';
import 'package:doctor_plus/Model/organization.dart';
import 'package:doctor_plus/Model/patient.dart';
import 'package:doctor_plus/View/Layout/Shop_app/cubit/states.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/Drug_Screen.dart';

import 'package:doctor_plus/View/Screens/LoginView/profile.dart';
import 'package:doctor_plus/View/Screens/Organization_Screen/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Model/doctor.dart';
import '../../../Layout/components/constants.dart';
import '../../../Screens/HomeView/home.dart';

class OrganizationCubit extends Cubit<OrgStates> {
  OrganizationCubit() :super(OrgInitialState());

  static OrganizationCubit get(context) => BlocProvider.of(context);

  int current_index = 0;
  firestroeCRUD db = firestroeCRUD();

  List<Organization> organizations = [];
  String? organization_id;
  Organization organization_detail = Organization();




  void Get_organizations ()async
  {
    emit(DrugLoadingGetDataState());
    try{
      print("=============here============================");
      organizations = await db.getDoctorOrganizations();
      emit(DrugLoadingSuccessState());

    }catch (error) {
      print("Failed to add the Medicine: $error");
      emit(DrugLoadingErrorState());
    }


  }

  Future<List<Organization>> Get_organizations_to_add ()async
  {
    emit(DrugLoadingGetDataState());
    try{
      print("=============here============================");
      organizations = await db.getDoctorOrganizations();


      emit(DrugLoadingSuccessState());
      return organizations;
    }catch (error) {
      print("Failed to add the Medicine: $error");
      emit(DrugLoadingErrorState());
      return[];
    }


  }


  void Get_organizations_with_patients_doctors(Organization org)async
  {
    emit(OrgLoadingGetDataState());
    try{
      print("=============here============================");
      organization_detail = await db.getOrganization_details(org);
      Organization_details = organization_detail;
      print("=============here============================");
      print(organization_detail.name);
      print("Length of doctors : --> ${organization_detail.doctors.length}");
      print("Length of Patients : --> ${organization_detail.patients.length}");
      print("=============here============================");

      emit(OrgLoadingSuccessState());
    }catch (error) {
      print("Failed to Fetch Organization Data: $error");
      emit(OrgLoadingErrorState());
    }


  }

  void Get_person_details_patients_organization(String patient_id)async
  {
    emit(DrugLoadingProfilePatientDataState());
    try{
      print("=============here============================");
      Patient? patient = await db.getPatient_byId_WithDrugs(patient_id);
     // print(patient!.drugs.toString());


      emit(DrugProfilePatientSuccessState(patient));
    }catch (error) {
      print("Failed to Fetch Organization Data: $error");
      emit(DrugProfilePatientErrorState("Failed to Fetch Organization Data"));
    }


  }


  Future<Doctor?> Get_Doctor_and_check({
    required String email,
    required String Org_id
})async
  {
    try{
      emit(GetDoctorLoadingDataState());
      Doctor? doc = await db.getDoc_By_Column_email(Doctor_email: email);
      bool? unique = false;
      if(doc?.email != null)
        {
          unique = await db.Check_if_doctor_not_on_organization(Org_id,doc!.id!);
          print(unique);
          unique == true ? emit(GetDoctorSuccessDataState(doc,true,true,"Get Doctor Success")) : emit(GetDoctorSuccessDataState(Doctor(),false,true," Doctor Already Assigned"));
          return doc;
        }
      else
        {
          emit(GetDoctorSuccessDataState(null,false,false,"Can't Find Doctor Success"));
          return null;
        }


    }catch (error) {
      print("Failed to Fetch Organization Data: $error");
      emit(GetDoctorErrorDataState("Failed to Fetch Organization Data"));
    }



  }

  void Assign_Doctor_To_Organization({
    required String doc_id,
    required String Org_id
  })async
  {
    try{
      emit(AssignDoctorLoadingDataState());
      bool assigned = await db.Assign_Doctor_to_org(Org_id,doc_id);

     emit(AssignDoctorSuccessDataState(assigned,"Doctor Added Successfully"));
    }catch (error) {
      print("Failed to Fetch Organization Data: $error");
      emit(AssignDoctorErrorDataState("Failed to Fetch Organization Data"));
    }



  }

  void Add_New_Organization({
    required Organization org
  })
  {
    emit(OrganizationLoadingAddDataState());
    db.add_new_organization(org).then((value)
    {
      value == true ?  emit(OrganizationSuccessAddState("Organization Created Successfully")) :  emit(OrganizationErrorAddState("Organization not Created some Thing Wrong"));
    });
  }




}

