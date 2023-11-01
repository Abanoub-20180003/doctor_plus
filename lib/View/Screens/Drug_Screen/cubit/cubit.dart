

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

      emit(DrugLoadingSuccessState());
    }catch (error) {
      print("Failed to add the Medicine: $error");
      emit(DrugLoadingErrorState());
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

