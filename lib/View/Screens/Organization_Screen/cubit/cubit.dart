

import 'package:doctor_plus/Controller/firestore_crud.dart';
import 'package:doctor_plus/Model/drug.dart';
import 'package:doctor_plus/Model/organization.dart';
import 'package:doctor_plus/View/Layout/Shop_app/cubit/states.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/Drug_Screen.dart';

import 'package:doctor_plus/View/Screens/LoginView/profile.dart';
import 'package:doctor_plus/View/Screens/Organization_Screen/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Layout/components/constants.dart';
import '../../../Screens/HomeView/home.dart';

class OrganizationCubit extends Cubit<OrgStates> {
  OrganizationCubit() :super(OrgInitialState());

  static OrganizationCubit get(context) => BlocProvider.of(context);

  bool theme = false;
  int current_index = 0;
  firestroeCRUD db = firestroeCRUD();
  final iconList = <IconData>[
    Icons.group,
    Icons.shopping_bag_outlined,
    Icons.car_rental,
    Icons.settings,
  ];

  List<Organization> organizations = [];
  List<Organization> search_List_drugs = [];

  Organization organization_detail = Organization();

  List<Widget> Screens = [
    Home(),
    profile(),
    drug_screen(),
    profile(),

  ];

  // void changeMarketoBottomNavbar(int index) {
  //   marketo_current_index = index;
  //
  //   emit(ShopChangeBottomNavState());
  // }



  // void get_payment_methods()
  // {
  //   emit(ShopLoadingGetPaymentsState());
  //   DioHelper.getData(url:payments_url,token:token).then((value)
  //   {
  //     payments = get_payments_model.fromJson(value.data);
  //     emit(ShopSuccessGetPaymentsState(payments!));
  //   }).catchError((onError)
  //   {
  //     print(onError.toString());
  //     emit(ShopErrorGetPaymentsState());
  //   });
  // }


  void Get_organizations ()async
  {
    emit(DrugLoadingGetDataState());
    try{
      print("=============here============================");
      organizations = await db.getDoctorOrganizations();

      print("=============here============================");
      print(organizations[0].name);
      print(organizations.length);
      print("=============here============================");

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

      print("=============here============================");
      print(organizations[0].name);
      print(organizations.length);
      print("=============here============================");

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


  void Delete_Drugs ({
    required String Id
})async
  {
    emit(DrugLoadingDeleteDataState());

    bool ok =   await db.deleteDrug(Id);
    ok == true ? emit(DrugDeleteSuccessState("Medicine Deleted Successfully")): emit(DrugDeleteErrorState("Some Thing Error"));
    Get_organizations();

  }



  void Add_Drug({
    required Drug drug
})
  {
    emit(DrugLoadingAddDataState());
    db.addDrug(drug).then((value)
    {
      value == true ?  emit(DrugSuccessAddState("Medicine Added Successfully")) :  emit(DrugErrorAddState("Medicine not Added some Thing Wrong"));
    });
  }




  //
  // void search_product({
  //   required String search_text,
  // }) async{
  //
  //   emit(ShopLoadingSearchDrugState());
  //   try{
  //     drugs = await db.getDrugs();
  //     if(search_text.length != 0)
  //       {
  //         print('----------------------------------------------');
  //         print(drugs.length);
  //         print('----------------------------------------------');
  //         drugs = drugs.where((product) =>
  //             product.name!.toLowerCase().contains(search_text.toLowerCase())).toList();
  //         // search_List.sort((a, b) => a.name!.compareTo(b.name!));
  //         print('------------------========================----------------------------');
  //         print(drugs);
  //         print('------------------===========================----------------------------');
  //         emit(ShopSuccessSearchDrugState("hEL"));
  //       }
  //       else
  //         {
  //           empty_search_product();
  //         }
  //   }catch(onError) {
  //     print(onError.toString());
  //     emit(ShopErrorSearchDrugState(onError.toString()));
  //   }
  // }
  //
  // void empty_search_product() async{
  //   drugs = await db.getDrugs();
  //   search_List_drugs = [];
  //
  //   emit(ShopSuccessemptySearchDrugState());
  // }













}

