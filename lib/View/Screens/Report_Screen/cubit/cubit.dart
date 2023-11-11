

import 'package:doctor_plus/Controller/firestore_crud.dart';
import 'package:doctor_plus/Model/medical_test_type.dart';
import 'package:doctor_plus/View/Screens/Report_Screen/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ReportCubit extends Cubit<ReportStates> {
  ReportCubit() :super(ReportInitialState());

  static ReportCubit get(context) => BlocProvider.of(context);


  int current_index = 0;
  firestroeCRUD db = firestroeCRUD();

  List<Medical_Test_type> reports = [];




  void Get_Medical_Tests_Types()async
  {
    emit(ReportLoadingHomeDataState());
    try{
      print("=============here============================");
      reports = await db.Get_Medical_Test_Types();

      print("=============here============================");
      print(reports);
      print(reports.length);
      print("=============here============================");

      emit(ReportSuccessHomeDataState());
    }catch (error) {
      print("Failed to add the Medicine: $error");
      emit(ReportErrorHomeDataState());
    }


  }


  void Delete_Test_Type ({
    required String Id
})async
  {
    emit(Test_Type_LoadingDeleteDataState());

    bool ok =   await db.Delete_Medical_Test(Id);
    ok == true ? emit(Test_Type_DeleteSuccessState("Test Type Deleted Successfully")): emit(Test_Type_DeleteErrorState("Some Thing Error"));
    Get_Medical_Tests_Types();

  }



  void Add_Medical_Tests_Type({
    required Medical_Test_type test_type
})
  {
    emit(Test_Type_AddDataState());
    db.Add_Medical_Test_Type(test_type).then((value)
    {
      value == true ?  emit(Test_Type_AddSuccessState("Test Type Added Successfully")) :  emit(Test_Type_AddErrorState("Test Type not Added some Thing Wrong"));
    });
  }

  void search_Medical_Test({
    required String search_text,
  }) async{

    emit(ShopLoadingSearchMedicalTestState());
    try{
      reports = await db.Get_Medical_Test_Types();
      if(search_text.length != 0)
      {
        print('----------------------------------------------');
        print(reports.length);
        print('----------------------------------------------');
        reports = reports.where((product) =>
            product.name!.toLowerCase().contains(search_text.toLowerCase())).toList();
        // search_List.sort((a, b) => a.name!.compareTo(b.name!));
        print('------------------========================----------------------------');
        print(reports);
        print('------------------===========================----------------------------');
        emit(ShopSuccessSearchMedicalTestState("hEL"));
      }
      else
      {
        empty_search_Medical_Test();
      }
    }catch(onError) {
      print(onError.toString());
      emit(ShopErrorSearchMedicalTestState(onError.toString()));
    }
  }

  void empty_search_Medical_Test() async{
    reports = await db.Get_Medical_Test_Types();

    emit(ShopSuccessemptySearchMedicalTestState());
  }



}

