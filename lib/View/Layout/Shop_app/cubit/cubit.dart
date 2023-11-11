

import 'dart:convert';

import 'package:doctor_plus/Controller/authentication.dart';
import 'package:doctor_plus/Controller/firestore_crud.dart';
import 'package:doctor_plus/Model/doctor.dart';
import 'package:doctor_plus/View/Layout/Shop_app/cubit/states.dart';
import 'package:doctor_plus/View/Layout/components/constants.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/Drug_Screen.dart';
import 'package:doctor_plus/View/Screens/LoginView/profile.dart';
import 'package:doctor_plus/View/Screens/Report_Screen/Report_Screen.dart';
import 'package:doctor_plus/network/Local/chaced_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Screens/HomeView/home.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() :super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  bool Darktheme = false;
  int current_index = 0;


  int marketo_current_index = 0;
  final iconList = <IconData>[
    Icons.group,
    Icons.shopping_bag_outlined,
    Icons.car_rental,
    Icons.settings,
  ];


  Authentication auth = Authentication();
  firestroeCRUD db = firestroeCRUD();

  List<Widget> Screens = [
    Home(),
    drug_screen(),
    report_screen(),
    profile(),

  ];

  void SaveTheme(bool theme) {
    Darktheme = theme;

    emit(ShopChangeBottomNavState());
  }

  void Add_Person_Drugs() {

    emit(ShopChangeBottomNavState());
  }

  void Remove_drug(int index) {

    drugs_added_patient.removeAt(index);
    emit(ShopChangeBottomNavState());
  }

  void changeBottomNavbar(int index) {
    current_index = index;

    emit(ShopChangeBottomNavState());
  }

  void changeTheme() {
    Darktheme = Darktheme == true ? false : true;
    update_theme_app(theme: Darktheme);
    emit(ShopChangeBottomNavState());
  }


  Future<void> login({
    required String email ,
    required String password
}) async {
    UserCredential loginResult;
    try {
      emit(AppLoadingLoginHomeState());
        loginResult = await auth.signInEmail(email, password);

      if (loginResult != null) {

        print("${loginResult.user!.uid.toString()}");
        print("===============ngma==============================");
        await db.getDocById(doctorId: loginResult.user!.uid.toString());
        print("===============ngma==============================");


        Doctor doctor = Doctor();
        doctor.id = loginResult.user!.uid;
        doctor.name = loginResult.user!.displayName;
        doctor.email = email;
        doctor.password = password;
        doctor_con = doctor;

        doctor_profile.id = loginResult.user!.uid;
        final doctorJson = jsonEncode(doctor.toJson());
        final doctor_data_Json = jsonEncode(doctor_profile.toJson());

        ChacheHelper.saveData(key: 'Id',
          value: loginResult.user!.uid,);

        ChacheHelper.saveData(key: 'profile',
          value: doctor_data_Json,);

        ChacheHelper.saveData(key: 'token',
          value: doctorJson,);
           emit(AppSuccessLoginDataState("Login Successfully"));
      }
      else {
        emit(AppErrorLoginDataState("Email Or Password Wrong"));
      }
    } catch (error) {
      emit(AppErrorLoginDataState("Email Or Password Wrong"));
    }
  }



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




  //
  //
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



//   void getProduct_Details({
//   required int id
// })
//   {
//     emit(ShopLoadingGoToMarketState());
//     DioHelper.getData(url:product_details,token:token).then((value)
//     {
//       print(value.data);
//       Market_Data = market_model.fromJson(value.data);
//       emit(ShopSuccessGoToMarketState(Market_Data!));
//     }).catchError((onError)
//     {
//       print(onError.toString());
//       emit(ShopErrorGoToMarketState());
//     });
//   }


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


  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }


}

