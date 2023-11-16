

import 'package:doctor_plus/Controller/firestore_crud.dart';
import 'package:doctor_plus/Model/patient.dart';
import 'package:doctor_plus/View/Layout/Shop_app/cubit/states.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/Drug_Screen.dart';
import 'package:doctor_plus/View/Screens/LoginView/profile.dart';
import 'package:doctor_plus/View/Screens/SearchView/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() :super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  bool theme = false;
  int current_index = 0;

  List<Patient> search_List = [];
  int marketo_current_index = 0;
  final iconList = <IconData>[
    Icons.group,
    Icons.shopping_bag_outlined,
    Icons.car_rental,
    Icons.settings,
  ];
  firestroeCRUD db = firestroeCRUD();
bool get_data = false;

  // void Go_to_Market()
  // {
  //   emit(ShopLoadingGoToMarketState());
  //   DioHelper.getData(url:Go_To_Market,token:token).then((value)
  //   {
  //     print(value.data);
  //     Market_Data = market_model.fromJson(value.data);
  //     emit(ShopSuccessGoToMarketState(Market_Data!));
  //   }).catchError((onError)
  //   {
  //     print(onError.toString());
  //     emit(ShopErrorGoToMarketState());
  //   });
  // }


  void get_patients() async{

    emit(ShopLoadingGetPatientsState());
    try{
      search_List = await db.getAllPatientsWithDrugs();
      get_data = true;
      emit(ShopSuccessGetPatientsState("hEL"));
    }catch(onError) {
      print(onError.toString());
      emit(ShopErrorGetPatientsState(onError.toString()));
    }
  }

  void search_product({
    required String search_text,
  }) async{

    emit(ShopLoadingSearchProductState());
    try{
      search_List = await db.getAllPatientsWithDrugs();
      print('----------------------------------------------');
      print(search_List.length);
      print('----------------------------------------------');
       search_List = search_List.where((product) =>
          product.name!.toLowerCase().contains(search_text.toLowerCase())).toList();
     // search_List.sort((a, b) => a.name!.compareTo(b.name!));
      print('------------------========================----------------------------');
      print(search_List);
      print('------------------===========================----------------------------');
      emit(ShopSuccessSearchProductState("hEL"));
    }catch(onError) {
      print(onError.toString());
      emit(ShopErrorSearchProductState(onError.toString()));
    }
  }

  void empty_search_product() async{
    search_List = await db.getAllPatientsWithDrugs();
    print('----------------------------------------------');
    print(search_List.length);
    print('----------------------------------------------');
    // search_List = [];
    emit(ShopSuccessemptySearchProductState());
  }

// void getUserData()
// {
//
//   emit(ShopLoadingGetProfileState());
//   DioHelper.getData(url:Profile,token:token).then((value)
//   {
//     User = UserModel.fromJson(value.data);
//     print(User!.data.id);
//     emit(ShopSuccessGetProfileState(User!));
//   }).catchError((onError)
//   {
//     print(onError.toString());
//     emit(ShopErrorGetProfileState());
//   });
// }

}