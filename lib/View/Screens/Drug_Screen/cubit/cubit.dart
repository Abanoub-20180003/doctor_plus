

import 'package:doctor_plus/Controller/firestore_crud.dart';
import 'package:doctor_plus/Model/drug.dart';
import 'package:doctor_plus/View/Layout/Shop_app/cubit/states.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/Drug_Screen.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/cubit/states.dart';
import 'package:doctor_plus/View/Screens/LoginView/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Screens/HomeView/home.dart';

class DrugCubit extends Cubit<DrugStates> {
  DrugCubit() :super(DrugInitialState());

  static DrugCubit get(context) => BlocProvider.of(context);

  bool theme = false;
  int current_index = 0;
  firestroeCRUD db = firestroeCRUD();
  final iconList = <IconData>[
    Icons.group,
    Icons.shopping_bag_outlined,
    Icons.car_rental,
    Icons.settings,
  ];

  List<Drug> drugs = [];
  List<Drug> search_List_drugs = [];



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


  void Get_Drugs ()async
  {
    emit(DrugLoadingGetDataState());
    try{
      print("=============here============================");
      drugs = await db.getDrugs();

      print("=============here============================");
      print(drugs);
      print(drugs.length);
      print("=============here============================");

      search_List_drugs = drugs;
      emit(DrugLoadingSuccessState());
    }catch (error) {
      print("Failed to add the Medicine: $error");
      emit(DrugLoadingErrorState());
    }


  }


  Future<List<Drug>> Get_Drugs_for_add ()async
  {
    emit(DrugLoadingGetDataState());
    try{
      print("=============here============================");
      drugs = await db.getDrugs();
      print(drugs.length);
      print("=============here============================");

      return  drugs;
      emit(DrugLoadingSuccessState());
    }catch (error) {
      print("Failed to add the Medicine: $error");
      emit(DrugLoadingErrorState());
      return[];
    }


  }


  void Delete_Drugs ({
    required String Id
})async
  {
    emit(DrugLoadingDeleteDataState());

    bool ok =   await db.deleteDrug(Id);
    ok == true ? emit(DrugDeleteSuccessState("Medicine Deleted Successfully")): emit(DrugDeleteErrorState("Some Thing Error"));
    Get_Drugs();

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





  void search_product({
    required String search_text,
  }) async{

    emit(ShopLoadingSearchDrugState());
    try{
      drugs = await db.getDrugs();
      if(search_text.length != 0)
        {
          print('----------------------------------------------');
          print(drugs.length);
          print('----------------------------------------------');
          drugs = drugs.where((product) =>
              product.name!.toLowerCase().contains(search_text.toLowerCase())).toList();
          // search_List.sort((a, b) => a.name!.compareTo(b.name!));
          print('------------------========================----------------------------');
          print(drugs);
          print('------------------===========================----------------------------');
          emit(ShopSuccessSearchDrugState("hEL"));
        }
        else
          {
            empty_search_product();
          }
    }catch(onError) {
      print(onError.toString());
      emit(ShopErrorSearchDrugState(onError.toString()));
    }
  }

  void empty_search_product() async{
    drugs = await db.getDrugs();
    search_List_drugs = [];

    emit(ShopSuccessemptySearchDrugState());
  }













}

