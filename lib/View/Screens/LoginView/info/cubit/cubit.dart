

import 'package:doctor_plus/Controller/firestore_crud.dart';
import 'package:doctor_plus/Model/doctor.dart';
import 'package:doctor_plus/Model/drug.dart';
import 'package:doctor_plus/View/Layout/Shop_app/cubit/states.dart';
import 'package:doctor_plus/View/Layout/components/constants.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/Drug_Screen.dart';
import 'package:doctor_plus/View/Screens/Drug_Screen/cubit/states.dart';
import 'package:doctor_plus/View/Screens/LoginView/info/cubit/states.dart';
import 'package:doctor_plus/View/Screens/LoginView/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() :super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);
  firestroeCRUD db = firestroeCRUD();









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
//   void Delete_Drugs ({
//     required String Id
// })async
//   {
//     emit(DrugLoadingDeleteDataState());
//
//     bool ok =   await db.deleteDrug(Id);
//     ok == true ? emit(DrugDeleteSuccessState("Medicine Deleted Successfully")): emit(DrugDeleteErrorState("Some Thing Error"));
//     Get_Drugs();
//
//   }
//
//
//
void update_doctor_profile({
    required Doctor doctor
})
  {
    try{
      emit(ProfileLoadingUpdateDataState());
      db.updateDoctor(doctor);
      doctor_profile.name = doctor.name;
      update_profile_local();
      emit(ProfileUpdateSuccessState("Profile Updated Successfully"));
    }catch(error){
      emit(ProfileUpdateErrorState("Try Again Later"));
    }

  }



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


  // bool isBottomSheetShown = false;
  // IconData fabIcon = Icons.edit;
  //
  // void changeBottomSheetState({
  //   required bool isShow,
  //   required IconData icon,
  // }) {
  //   isBottomSheetShown = isShow;
  //   fabIcon = icon;
  //
  //   emit(AppChangeBottomSheetState());
  // }


}

