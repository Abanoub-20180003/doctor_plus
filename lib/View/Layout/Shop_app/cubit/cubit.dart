

import 'package:doctor_plus/View/Layout/Shop_app/cubit/states.dart';
import 'package:doctor_plus/View/Layout/components/constants.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/Drug_Screen.dart';
import 'package:doctor_plus/View/Screens/LoginView/profile.dart';
import 'package:doctor_plus/View/Screens/Report_Screen/Report_Screen.dart';
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

